resource "azurerm_storage_account" "sa" {
  name                     = "${var.sa_name}"
  resource_group_name      = "${var.rg_name}"
  location                 = "${var.location}"
  account_tier             = "${var.account_tier}"
  account_replication_type = "${var.account_replication_type}"
  account_kind             = "FileStorage"
  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_share" "share" {
  name                 = "${var.share_name}"
  storage_account_name = "${azurerm_storage_account.sa.name}"
  quota                = "${var.quota}"
}

resource "kubernetes_secret" "fileshare-secret" {
  metadata {
    name = "${var.name}-${var.environment}-fileshare"
  }
  data = {
    azurestorageaccountname = "${var.sa_name}"
    azurestorageaccountkey = "${azurerm_storage_account.sa.primary_access_key}"
  }
  type = "Opaque"
}
provider "azurerm" {
  version = "~>1.29"
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.name}-${var.environment}-sa-rg"
  location = "${var.location}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.sa_name}"
  resource_group_name      = "${azurerm_resource_group.resource_group.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.environment}"
  }
}
resource "azurerm_storage_container" "storage_container" {
  name                  = "${var.name}-${var.environment}-sc"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  storage_account_name  = "${azurerm_storage_account.storage_account.name}"
  container_access_type = "private"
}

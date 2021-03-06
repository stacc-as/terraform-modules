provider "azurerm" {
  version = "~>1.29"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-acr-rg"
  location = var.location

  tags = {
    environment = var.environment
    managedBy   = "terraform"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.cr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku                      = var.cr_sku
  admin_enabled            = false
  georeplication_locations = var.cr_georeplication_locations

  tags = {
    environment = var.environment
    managedBy   = "terraform"
  }
}

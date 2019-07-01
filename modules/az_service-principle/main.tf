provider "azurerm" {
  version = "1.30.1"
}

provider "azuread" {
  version = "0.4.0"
}

provider "random" {
  version = "2.1.2"
}

resource "azuread_application" "application" {
  name = "${var.name}-sp"
}

resource "azuread_service_principal" "service_principal" {
  application_id = "${azuread_application.application.application_id}"
}

resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = "${azuread_service_principal.service_principal.id}"
  value                = "${random_string.password.result}"
  end_date             = "2025-01-01T01:02:03Z"
}

resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "/@\" "
}
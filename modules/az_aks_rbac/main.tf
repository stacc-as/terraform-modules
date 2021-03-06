provider "azurerm" {
  version = "~>1.33.0"
}

provider "azuread" {
  version = "~>0.6.0"
}

provider "random" {
  version = "2.1.2"
}

resource "azuread_application" "client" {
  name       = "${var.name}-${var.environment}_k8s_client"
  reply_urls = ["https://${var.name}-${var.environment}_k8s_client"]
  type       = "native"

  required_resource_access {
    # AKS ad application server
    resource_app_id = azuread_application.server.application_id

    resource_access {
      # Server app Oauth2 permissions id
      id   = azuread_application.server.oauth2_permissions[0].id
      type = "Scope"
    }
  }
}

resource "azuread_service_principal" "client" {
  application_id = azuread_application.client.application_id
}

resource "azuread_service_principal_password" "client" {
  service_principal_id = azuread_service_principal.client.id
  value                = random_string.application_client_password.result
  end_date             = timeadd(timestamp(), "87600h") # 10 years

  lifecycle {
    ignore_changes = [end_date]
  }
}

resource "random_string" "application_client_password" {
  length  = 16
  special = false

  keepers = {
    service_principal = azuread_service_principal.client.id
  }
}

resource "azuread_application" "server" {
  name                    = "${var.name}-${var.environment}_k8s_server"
  reply_urls              = []
  type                    = "webapp/api"
  group_membership_claims = "All"
  identifier_uris         = ["https://${var.name}-${var.environment}_k8s_server"]

  required_resource_access {
    # MicrosoftGraph API
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    # APPLICATION PERMISSIONS: "Read directory data":
    # 7ab1d382-f21e-4acd-a863-ba3e13f7da61
    resource_access {
      id   = "7ab1d382-f21e-4acd-a863-ba3e13f7da61"
      type = "Role"
    }

    # DELEGATED PERMISSIONS: "Sign in and read user profile":
    # e1fe6dd8-ba31-4d61-89e7-88639da4683d
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }

    # DELEGATED PERMISSIONS: "Read directory data":
    # 06da0dbc-49e2-44d2-8312-53f166ab848a
    resource_access {
      id   = "06da0dbc-49e2-44d2-8312-53f166ab848a"
      type = "Scope"
    }
  }
}

resource "azuread_service_principal" "server" {
  application_id = azuread_application.server.application_id
}

resource "azuread_service_principal_password" "server" {
  service_principal_id = azuread_service_principal.server.id
  value                = random_string.application_server_password.result
  end_date             = timeadd(timestamp(), "87600h") # 10 years

  # The end date will change at each run (terraform apply), causing a new password to
  # be set. So we ignore changes on this field in the resource lifecyle to avoid this
  # behaviour.
  # If the desired behaviour is to change the end date, then the resource must be
  # manually tainted.
  lifecycle {
    ignore_changes = [end_date]
  }
}

resource "random_string" "application_server_password" {
  length  = 16
  special = false

  keepers = {
    service_principal = azuread_service_principal.server.id
  }
}

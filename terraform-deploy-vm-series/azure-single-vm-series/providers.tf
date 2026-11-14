terraform {
  required_version = "1.17.2"
}

provider "azurerm" {
  features {}

  # Credentials for connecting to Azure
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

# Credentials for connecting to Azure
client_id       = "12312312-1231-1231-1231-123123123123"
client_secret   = "abcabcabcabcabcabcabcabcabcabcabcabcabca"
tenant_id       = "12312312-1231-1231-1231-123123123123"
subscription_id = "12312312-1231-1231-1231-123123123123"

# Azure variable values
name_prefix    = "testing"
location       = "UK South"
resource_group = "vmseries-rg"

# Azure VNET variable values
vnet_address_space = ["10.10.0.0/16"]
mgmt_subnet        = "10.10.10.0/24"
outside_subnet     = "10.10.20.0/24"
inside_subnet      = "10.10.30.0/24"
network_security_groups = {
  "allow_all" = {
    location = "UK South"
    rules = {
      "AllowAllOutbound" = {
        priority                   = 100
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      "AllowAllOutbound" = {
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

# PAN-OS VM-Series variable values
vmseries_sku     = "bundle2"
vmseries_version = "10.2.3"
username         = "panos"
password         = "somethingSecret"

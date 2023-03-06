# The Resource Group
resource "azurerm_resource_group" "the_resourcegroup" {
  name     = "${var.name_prefix}-${var.resource_group}"
  location = var.location
}

# The Virtual Network (VNET)
module "vnet" {
  source  = "PaloAltoNetworks/vmseries-modules/azurerm//modules/vnet"
  version = "0.5.1"

  virtual_network_name    = "${var.name_prefix}-vnet"
  location                = var.location
  resource_group_name     = azurerm_resource_group.the_resourcegroup.name
  address_space           = var.vnet_address_space
  network_security_groups = var.network_security_groups
  subnets = {
    "subnet-mgmt" = {
      address_prefixes       = [var.mgmt_subnet]
      network_security_group = "allow_all"
    }
    "subnet-inside" = {
      address_prefixes       = [var.outside_subnet]
      network_security_group = "allow_all"
    }
    "subnet-outside" = {
      address_prefixes       = [var.inside_subnet]
      network_security_group = "allow_all"
    }
  }
}

# The VM-Series virtual machine
module "vmseries" {
  source  = "PaloAltoNetworks/vmseries-modules/azurerm//modules/vmseries"
  version = "0.5.1"

  location            = var.location
  resource_group_name = azurerm_resource_group.the_resourcegroup.name
  name                = var.name_prefix
  username            = var.username
  password            = var.password
  img_sku             = var.vmseries_sku
  img_version         = var.vmseries_version

  interfaces = [
    {
      name             = "${var.name_prefix}-mgmt"
      subnet_id        = lookup(module.vnet.subnet_ids, "subnet-mgmt", null)
      create_public_ip = true
    },
    {
      name             = "${var.name_prefix}-outside"
      subnet_id        = lookup(module.vnet.subnet_ids, "subnet-outside", null)
      create_public_ip = true
    },
    {
      name             = "${var.name_prefix}-inside"
      subnet_id        = lookup(module.vnet.subnet_ids, "subnet-inside", null)
      create_public_ip = false
    },
  ]
}

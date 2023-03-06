# The Virtual Private Cloud (VPC)
module "the_vpc" {
  source     = "PaloAltoNetworks/vmseries-modules/google//modules/vpc"
  version    = "0.5.0"
  project_id = var.gcp-project
  region     = var.gcp-region

  networks = [
    {
      name            = "${var.name_prefix}mgmt"
      subnetwork_name = "${var.name_prefix}mgmt"
      ip_cidr_range   = var.mgmt-subnet-cidr
      allowed_sources = var.allowed_sources
    },
    {
      name            = "${var.name_prefix}outside"
      subnetwork_name = "${var.name_prefix}outside"
      ip_cidr_range   = var.outside-subnet-cidr
      allowed_sources = var.allowed_sources
    },
    {
      name            = "${var.name_prefix}inside"
      subnetwork_name = "${var.name_prefix}inside"
      ip_cidr_range   = var.inside-subnet-cidr
      allowed_sources = var.allowed_sources
    }
  ]
}

# The VM-Series virtual machine
module "the_vmseries" {
  source         = "PaloAltoNetworks/vmseries-modules/google//modules/vmseries"
  version        = "0.5.0"
  name           = var.name_prefix
  zone           = var.gcp-zone
  vmseries_image = var.pan-os-version
  ssh_keys       = var.ssh_keys

  network_interfaces = [
    {
      subnetwork       = module.the_vpc.subnetworks["${var.name_prefix}mgmt"].self_link
      create_public_ip = true
    },
    {
      subnetwork       = module.the_vpc.subnetworks["${var.name_prefix}outside"].self_link
      create_public_ip = true
    },
    {
      subnetwork       = module.the_vpc.subnetworks["${var.name_prefix}inside"].self_link
      create_public_ip = false
    },
  ]
}

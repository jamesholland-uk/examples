# The Virtual Private Cloud (VPC) Networks
module "mgmt-vpc-network" {
  source     = "PaloAltoNetworks/swfw-modules/google//modules/vpc"
  version    = "~> 2.0.0"
  project_id = var.gcp-project
  name       = "${var.name_prefix}-mgmt"

  subnetworks = {
    "${var.name_prefix}-mgmt-sub" = {
      name            = "${var.name_prefix}-mgmt-sub"
      ip_cidr_range   = var.mgmt-subnet-cidr
      allowed_sources = var.allowed_sources
      region          = var.gcp-region
    }
  }
  firewall_rules = {
    allow-ingress = {
      name             = "allow-${var.name_prefix}-mgmt-ingress"
      source_ranges    = ["0.0.0.0/0"]
      priority         = "1000"
      allowed_protocol = "all"
      allowed_ports    = []
    }
  }
}

module "outside-vpc-network" {
  source     = "PaloAltoNetworks/swfw-modules/google//modules/vpc"
  version    = "~> 2.0.0"
  project_id = var.gcp-project
  name       = "${var.name_prefix}-outside"

  subnetworks = {
    "${var.name_prefix}-outside-sub" = {
      name            = "${var.name_prefix}-outside-sub"
      ip_cidr_range   = var.outside-subnet-cidr
      allowed_sources = var.allowed_sources
      region          = var.gcp-region
    }
  }
  firewall_rules = {
    allow-ingress = {
      name             = "allow-${var.name_prefix}-outside-ingress"
      source_ranges    = ["0.0.0.0/0"]
      priority         = "1000"
      allowed_protocol = "all"
      allowed_ports    = []
    }
  }
}

module "inside-vpc-network" {
  source     = "PaloAltoNetworks/swfw-modules/google//modules/vpc"
  version    = "~> 2.0.0"
  project_id = var.gcp-project
  name       = "${var.name_prefix}-inside"

  subnetworks = {
    "${var.name_prefix}-inside-sub" = {
      name            = "${var.name_prefix}-inside-sub"
      ip_cidr_range   = var.inside-subnet-cidr
      allowed_sources = var.allowed_sources
      region          = var.gcp-region
    }
  }
}

# The VM-Series virtual machine
module "the_vmseries" {
  source         = "PaloAltoNetworks/swfw-modules/google//modules/vmseries"
  version        = "~> 2.0.0"
  name           = var.name_prefix
  zone           = var.gcp-zone
  vmseries_image = var.pan-os-version
  ssh_keys       = var.ssh_key
  bootstrap_options = {
    dns-primary                           = var.dns_server_1
    dns-secondary                         = var.dns_server_2
    panorama-server                       = var.panorama_primary
    panorama-server-2                     = var.panorama_secondary
    dgname                                = var.dgname
    tplname                               = var.tplname
    vm-series-auto-registration-pin-id    = var.vm-series-auto-registration-pin-id
    vm-series-auto-registration-pin-value = var.vm-series-auto-registration-pin-value
    plugin-op-commands                    = var.plugin-op-commands
    authcodes                             = var.authcodes
  }

  network_interfaces = [
    {
      subnetwork       = module.mgmt-vpc-network.subnetworks["${var.name_prefix}-mgmt-sub"].self_link
      create_public_ip = true
    },
    {
      subnetwork       = module.outside-vpc-network.subnetworks["${var.name_prefix}-outside-sub"].self_link
      create_public_ip = true
    },
    {
      subnetwork       = module.inside-vpc-network.subnetworks["${var.name_prefix}-inside-sub"].self_link
      create_public_ip = false
    },
  ]
}

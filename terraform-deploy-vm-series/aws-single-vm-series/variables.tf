# Variable to allow each deployment uniquely named and labelled
variable "name_prefix" {
  description = "An identifier, ideally unique per deployment to maintain unique names of VNETs, VMs, etc"
  type        = string
}

# Credentials for connecting to AWS
variable "aws_region" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

# AWS Variables
variable "vpc_supernet" {
  type = string
}

variable "mgmt_subnet" {
  description = "Address space for ths subnet"
  type        = string
}

variable "outside_subnet" {
  description = "Address space for ths subnet"
  type        = string
}

variable "inside_subnet" {
  description = "Address space for ths subnet"
  type        = string
}

variable "vpc_availability_zone" {
  type = string
}

variable "security_vpc_security_groups" {
  type = map(any)
}

# PAN-OS VM-Series Variables
variable "ssh_key" {
  description = "SSH key used for initial PAN-OS administrative access"
  type        = string
}

variable "vm_series_product_code" {
  description = "Type of license mode: BYOL, or PAYG Bundles. Product codes from https://docs.paloaltonetworks.com/vm-series/11-0/vm-series-deployment/set-up-the-vm-series-firewall-on-aws/deploy-the-vm-series-firewall-on-aws/obtain-the-ami/get-amazon-machine-image-ids"
  type        = string
}

variable "vm_series_version" {
  description = "Version of PAN-OS to use for the VM-Series"
  type        = string
}

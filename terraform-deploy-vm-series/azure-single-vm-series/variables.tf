# Credentials for connecting to Azure
variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

# Variable to make each deployment uniquely named and labelled
variable "name_prefix" {
  description = "An identifier, ideally unique per deployment to maintain unique names of VNETs, VMs, etc"
  type        = string
}

# Azure variables
variable "location" {
  description = "The Azure region to use"
  type        = string
}

variable "resource_group" {
  description = "Name of the Resource Group to create"
  type        = string
}

# Azure VNET variables
variable "vnet_address_space" {
  description = "Supernet of address space for the VNET"
  type        = list(any)
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

variable "network_security_groups" {
  description = "Azure Network Security Groups applied to the VNET"
}

# PAN-OS and VM-Series variables
variable "username" {
  description = "Initial PAN-OS administrative username"
  type        = string
}

variable "password" {
  description = "Initial PAN-OS administrative password"
  type        = string
}

variable "vmseries_sku" {
  description = "VM-Series SKU, for example `bundle1`, or `bundle2`. Or `byol` and bring your own auth codes"
  type        = string
}

variable "vmseries_version" {
  description = "VM-Series PAN-OS version"
  type        = string
}

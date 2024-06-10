# Variable to allow each deployment uniquely named and labelled
variable "name_prefix" {
  description = "An identifier, ideally unique per deployment to maintain unique names of VNETs, VMs, etc"
  type        = string
}

# GCP variable values
variable "gcp-project" {
  description = "The GCP project to use"
  type        = string
}

variable "gcp-region" {
  description = "The GCP region to use"
  type        = string
}

variable "gcp-zone" {
  description = "The GCP zone to use"
  type        = string
}

variable "credentials_file" {
  description = "Path to file containing GCP JSON-formatted credentials"
  type        = string
}

# GCP Network variable values
variable "mgmt-subnet-cidr" {
  description = "Address space for ths subnet"
  type        = string
}

variable "outside-subnet-cidr" {
  description = "Address space for ths subnet"
  type        = string
}

variable "inside-subnet-cidr" {
  description = "Address space for ths subnet"
  type        = string
}

variable "allowed_sources" {
  description = "IP addresses used in access lists allowing access to the deployed resources"
  type        = list(any)
}

# PAN-OS VM-Series variable values
variable "pan-os-version" {
  description = "VM-Series PAN-OS version"
  type        = string
}

variable "ssh_key" {
  description = "SSH key used for initial PAN-OS administrative access"
  type        = string
}

variable "dns_server_1" {
  description = "DNS server 1 for PAN-OS"
  type        = string
}

variable "dns_server_2" {
  description = "DNS server 2 for PAN-OS"
  type        = string
}

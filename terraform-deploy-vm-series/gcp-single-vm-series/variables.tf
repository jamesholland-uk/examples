variable "name_prefix" {
  type = string
}

variable "gcp-project" {
  type = string
}

variable "gcp-region" {
  type = string
}

variable "gcp-zone" {
  type = string
}

variable "mgmt-subnet-cidr" {
  type = string
}

variable "outside-subnet-cidr" {
  type = string
}

variable "inside-subnet-cidr" {
  type = string
}

variable "pan-os-version" {
  type = string
}

variable "ssh_keys" {
  type = string
}

variable "allowed_sources" {
  type = list
}
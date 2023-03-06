terraform {
  required_version = ">= 0.15.3, < 2.0"
}

provider "google" {
  project = var.gcp-project
  region  = var.gcp-region
  credentials = file("gcp.json")
}

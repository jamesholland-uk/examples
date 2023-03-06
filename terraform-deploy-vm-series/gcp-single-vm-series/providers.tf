terraform {
  required_version = ">= 0.15.3, < 2.0"
}

provider "google" {
  # GCP Variables
  project = var.gcp-project
  region  = var.gcp-region
  # Credentials for connecting to GCP
  credentials = file("gcp.json")
}

terraform {
  required_version = "1.17.1"
}

provider "google" {
  # GCP Variables
  project     = var.gcp-project
  region      = var.gcp-region
  credentials = file(var.credentials_file)
}

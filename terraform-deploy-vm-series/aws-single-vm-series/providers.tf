terraform {
  required_version = "1.16.6"
}

# Credentials and config for AWS
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

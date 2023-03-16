terraform {
  required_version = ">= 0.15.3, < 2.0"
}

# Credentials and config for AWS
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

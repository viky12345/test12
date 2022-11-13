provider "aws" {
  region  = var.aws_region
  # version = ">= 3.0"
}
terraform {
  required_version = ">= 0.12.24"
}

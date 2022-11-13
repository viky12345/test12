provider "aws" {
  region  = var.AWS_REGION
  # version = ">= 3.0"
}
terraform {
  required_version = ">= 0.12.24"
}

# -----------------------------------------------------------------------------
# Terraform Configuration
# Demonstrates conditional logic using modules
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# -----------------------------------------------------------------------------
# Provider Configuration
# -----------------------------------------------------------------------------

provider "aws" {
  region = "us-west-2"
}

# -----------------------------------------------------------------------------
# EC2 Module
# -----------------------------------------------------------------------------

module "webserver" {
  source = "./modules/ec2"

  servername    = "calabvm"
  instance_size = "t2.micro"
}
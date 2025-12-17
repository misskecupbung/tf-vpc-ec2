# -----------------------------------------------------------------------------
# Terraform Configuration
# Demonstrates count-based scaling with dynamic EBS blocks
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
# EC2 Module with Count
# Creates multiple instances with additional EBS volumes
# -----------------------------------------------------------------------------

module "server" {
  source = "./modules/ec2"
  count  = 3

  servername                  = "testserver${count.index}"
  associate_public_ip_address = false

  ebs_block_device = [
    {
      device_name           = "/dev/sdh"
      volume_size           = "4"
      volume_type           = "gp3"
      delete_on_termination = "true"
    },
    {
      device_name           = "/dev/sdj"
      volume_size           = "4"
      volume_type           = "gp3"
      delete_on_termination = "true"
    }
  ]
}
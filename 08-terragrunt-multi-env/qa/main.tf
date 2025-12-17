# -----------------------------------------------------------------------------
# QA Environment
# VPC and Subnet for QA workloads
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

# -----------------------------------------------------------------------------
# Provider Configuration
# -----------------------------------------------------------------------------

provider "aws" {
  region = "us-west-2"
}

# -----------------------------------------------------------------------------
# VPC Resources
# -----------------------------------------------------------------------------

resource "aws_vpc" "qa" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "qa-vpc"
    Environment = "QA"
  }
}

resource "aws_subnet" "qa" {
  vpc_id            = aws_vpc.qa.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name        = "qa-subnet"
    Environment = "QA"
  }
}

# -----------------------------------------------------------------------------
# Terraform Configuration
# Demonstrates using module outputs for resource tagging
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
# VPC Resources
# -----------------------------------------------------------------------------

resource "aws_vpc" "prod" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "prod-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "prod-subnet"
  }
}

# -----------------------------------------------------------------------------
# Security Group
# -----------------------------------------------------------------------------

resource "aws_security_group" "ec2" {
  name        = "prod-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.prod.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "prod-ec2-sg"
  }
}

# -----------------------------------------------------------------------------
# EC2 Module
# -----------------------------------------------------------------------------

module "webserver" {
  source = "./modules/ec2"

  servername         = "calabvm"
  instance_size      = "t2.micro"
  subnet_id          = aws_subnet.main.id
  security_group_ids = [aws_security_group.ec2.id]
}

# -----------------------------------------------------------------------------
# Additional Resource Tag
# Demonstrates using module outputs
# -----------------------------------------------------------------------------

resource "aws_ec2_tag" "environment" {
  resource_id = module.webserver.id
  key         = "Environment"
  value       = "Production"
}
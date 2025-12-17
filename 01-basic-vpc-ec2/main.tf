# -----------------------------------------------------------------------------
# Terraform Configuration
# Creates a VPC with a subnet and an EC2 instance
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
  region = var.aws_region
}

# -----------------------------------------------------------------------------
# VPC Resources
# -----------------------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.servername}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.servername}-subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.servername}-igw"
  }
}

# -----------------------------------------------------------------------------
# Security Group
# -----------------------------------------------------------------------------

resource "aws_security_group" "ec2" {
  name        = "${var.servername}-sg"
  description = "Security group for ${var.servername} EC2 instance"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.servername}-sg"
  }
}

# -----------------------------------------------------------------------------
# EC2 Instance
# -----------------------------------------------------------------------------

resource "aws_instance" "server" {
  ami                    = lookup(var.ami_ids, var.os_type, null)
  instance_type          = var.instance_size
  monitoring             = var.ec2_monitoring
  vpc_security_group_ids = [aws_security_group.ec2.id]
  subnet_id              = aws_subnet.main.id

  root_block_device {
    delete_on_termination = var.disk.delete_on_termination
    encrypted             = var.disk.encrypted
    volume_size           = var.disk.volume_size
    volume_type           = var.disk.volume_type
  }

  tags = {
    Name = var.servername
  }
}
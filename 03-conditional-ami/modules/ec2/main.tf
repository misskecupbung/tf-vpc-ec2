# -----------------------------------------------------------------------------
# EC2 Module with Conditional AMI Selection
# Uses data source to fetch latest Ubuntu AMI if not specified
# -----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

# -----------------------------------------------------------------------------
# Data Sources
# -----------------------------------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# -----------------------------------------------------------------------------
# EC2 Instance
# Uses conditional expression to select AMI
# -----------------------------------------------------------------------------

resource "aws_instance" "server" {
  ami           = var.ami != "" ? var.ami : data.aws_ami.ubuntu.id
  instance_type = var.instance_size

  tags = {
    Name = var.servername
  }
}

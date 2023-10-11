terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.7.0"
    }
  }
}
data "aws_ami" "default" {
  most_recent = "true"
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
resource "aws_instance" "server" {
    ami           = var.ami != "" ? var.ami : data.aws_ami.default.image_id
    instance_type = var.instance_size
    tags = {
        Name = "calabvm"
    }
}

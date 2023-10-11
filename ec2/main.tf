terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.7"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "calabvm-subnet"
  }
}
resource "aws_instance" "server1" {
    ami           = "ami-01fee56b22f308154"
    instance_type = "t3.micro"
    monitoring = true
    vpc_security_group_ids = [aws_vpc.example.default_security_group_id]
    subnet_id = aws_subnet.example.id               
    root_block_device {
        delete_on_termination = false
        encrypted = true
        volume_size = "8"
        volume_type = "standard"
    }
    tags = {
        Name = "calabvm1"
    }
}
resource "aws_instance" "server2" {
    ami           = "ami-01fee56b22f308154"
    instance_type = "t3.micro"
    monitoring = true
    vpc_security_group_ids = [aws_vpc.example.default_security_group_id]
    subnet_id = aws_subnet.example.id               
    root_block_device {
        delete_on_termination = false
        encrypted = true
        volume_size = "8"
        volume_type = "standard"
    }
    tags = {
        Name = "calabvm2"
    }
}
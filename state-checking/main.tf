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
resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "subnet"
  }
}
module "webserver" {
    source = "./modules/ec2"
    servername = "calabvm"
    instance_size = "t2.micro"
    subnet_id = aws_subnet.sub1.id
    security_group_ids = [aws_vpc.prod.default_security_group_id]
}
resource "aws_ec2_tag" "tags" {
  resource_id = module.webserver.id
  key         = "Environment"
  value       = "Production"
}
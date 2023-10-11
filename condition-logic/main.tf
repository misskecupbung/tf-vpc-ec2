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
module "webserver" {
    source = "./modules/ec2"
    servername = "calabvm"
    instance_size = "t2.micro"
}
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

resource "aws_ecr_repository" "ecr" {
  name = "catest"
  provisioner "local-exec" {
    when = destroy
    command = <<EOF
    $(aws ecr get-login --region us-west-2 --no-include-email)
    docker pull ${self.repository_url}:latest
    docker save --output catest.tar ${self.repository_url}:latest 
    EOF
  }
}

#Import Container Image to Elastic Container Registry
resource "null_resource" "image" {
  provisioner "local-exec" {
    command = <<EOF
       $(aws ecr get-login --region us-west-2 --no-include-email)
       docker pull hello-world:latest
       docker tag hello-world:latest ${aws_ecr_repository.ecr.repository_url}
       docker push ${aws_ecr_repository.ecr.repository_url}:latest
   EOF
  }
}

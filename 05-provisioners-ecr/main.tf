# -----------------------------------------------------------------------------
# Terraform Configuration
# Demonstrates provisioners with ECR
# WARNING: Provisioners should be used as a last resort
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
# ECR Repository with Destroy-time Provisioner
# Saves the container image locally before repository deletion
# -----------------------------------------------------------------------------

resource "aws_ecr_repository" "ecr" {
  name                 = "catest"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOF
      aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${self.repository_url}
      docker pull ${self.repository_url}:latest
      docker save --output catest.tar ${self.repository_url}:latest
    EOF
  }

  tags = {
    Name = "catest"
  }
}

# -----------------------------------------------------------------------------
# Import Container Image to ECR
# Pushes a sample image to the repository after creation
# -----------------------------------------------------------------------------

resource "null_resource" "image" {
  depends_on = [aws_ecr_repository.ecr]

  provisioner "local-exec" {
    command = <<-EOF
      aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${aws_ecr_repository.ecr.repository_url}
      docker pull hello-world:latest
      docker tag hello-world:latest ${aws_ecr_repository.ecr.repository_url}:latest
      docker push ${aws_ecr_repository.ecr.repository_url}:latest
    EOF
  }
}

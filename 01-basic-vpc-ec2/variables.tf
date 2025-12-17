# -----------------------------------------------------------------------------
# General Variables
# -----------------------------------------------------------------------------

variable "servername" {
  description = "Name of the server (used for resource naming)"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-west-2a"
}

# -----------------------------------------------------------------------------
# Network Variables
# -----------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

# -----------------------------------------------------------------------------
# EC2 Instance Variables
# -----------------------------------------------------------------------------

variable "ami_ids" {
  description = "Map of AMI IDs by OS type"
  type        = map(string)
  default = {
    linux   = "ami-0d398eb3480cb04e7"
    windows = "ami-0afb7a78e89642197"
  }
}

variable "os_type" {
  description = "OS to deploy (linux or windows)"
  type        = string

  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "OS type must be either 'linux' or 'windows'."
  }
}

variable "instance_size" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_monitoring" {
  description = "Enable detailed monitoring on the EC2 instance"
  type        = bool
  default     = false
}

variable "disk" {
  description = "Root block device configuration"
  type = object({
    delete_on_termination = bool
    encrypted             = bool
    volume_size           = number
    volume_type           = string
  })

  default = {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp3"
  }
}
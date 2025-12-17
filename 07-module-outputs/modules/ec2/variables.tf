# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

variable "servername" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "instance_size" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
}

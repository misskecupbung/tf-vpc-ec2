# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

variable "servername" {
  description = "Name of the server"
  type        = string
}

variable "ami" {
  description = "AMI ID to deploy (uses latest Ubuntu if not specified)"
  type        = string
  default     = ""
}

variable "instance_size" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
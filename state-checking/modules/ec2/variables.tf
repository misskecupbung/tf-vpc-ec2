variable "instance_size" {
    description = "Size of the EC2 instance"
    type = string
    default = "t2.micro"
}
variable "servername" {
    description = "Name of the EC2 Instance tag"
    type = string
}
variable "subnet_id" {
    description = "Subnet ID assigned to the EC2 Instance"
    type = string
}
variable "security_group_ids" {
    description = "Security group IDs assigned to the EC2 Instance"
    type = list(string)
}
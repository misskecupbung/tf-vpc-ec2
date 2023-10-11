variable "servername"{
    description = "Name of the server"
    type = string
}
variable "ami" { 
    description = "AMI ID to deploy"
    type = string
    default = ""
}
variable "instance_size" {
    description = "Size of the EC2 instance"
    type = string
    default = "t2.micro"
}
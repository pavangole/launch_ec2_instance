variable "ami_id" {
  description = "Give Amazon Machine Image Id Default is Redhat"
  type = string
  default = "ami-06a0b4e3b7eb7a300"
}

variable "instance_type" {
  description = "Give the instance type "
  type = string
  default = "t2.micro"
}

variable "region" {
  description = "Launch instance in which region"
  type = string
  default = "ap-south-1"
}

variable "instance_count" {
    description = "Number of instances to launch"
    type = number
    default = 1

}

variable "ssh_key_name" {
    description = "Give the name for ssh key you want to use"
    type = string
    default = "promkey"
}

variable "storage_size" {
    description = "Give Root Storage Size"
    type = number
    default = 10
}  

variable "instance_name" {
    description = "How instance shoud be call"
    type = string
    default = "prometheous"
}

variable "security_group_name" {
    description = "Give the name of the security group"
    type = string
    default = "prom-security"
}
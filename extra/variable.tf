variable "ami" {
  description = "ami of the instance"
  type = string
  default = "ami-089a545a9ed9893b6"
}

variable "instance_type" {
  description = "instance_type"
  type = string
  default = "t2.micro"
}

variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map
}

variable "aws_security_group" {
  description = "aws_security_group name"
  type        = string
  default = "security"
}

variable "aws_instance_name" {
  description = "aws_instance_name "
  type        = string
  default = "ec2"
}
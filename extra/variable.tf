variable "AWS_REGION" {
  description = "Region where you wants to deploy this terrraform"
  type = string
  default = "eu-west-2"
}

variable "key_name" {
  description = "Existing Keyname for EC2"
  type = string
  default = "das-ec2"
}

variable "role_name" {
  description = "Role name"
  default = "dasec2"
}

variable "ami" {
  description = "ami of the instance"
  type = string
  default = "ami-0f540e9f488cfa27d"
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
  default = "das-security"
}

variable "aws_instance_name" {
  description = "aws_instance_name "
  type        = string
  default = "das-ec2"
}
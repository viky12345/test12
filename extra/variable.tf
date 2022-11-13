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


variable "aws_instance_name" {
  description = "aws_instance_name "
  type        = string
  default = "ec2"
}
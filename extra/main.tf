resource "aws_instance" "das-ec2" { 
    count = "1"
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = "subnet-5e7a9a23"
    vpc_security_group_ids = [aws_security_group.das_security.id]
    monitoring = "true"
    user_data = file("${path.module}/install-ssm.sh")

    tags = {
        Name = var.aws_instance_name
    }
}
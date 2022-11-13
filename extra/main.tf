#Instance Role
resource "aws_iam_role" "das_role" {
  name = "test-ssm-ec2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name = var.role_name
  }
}

data "aws_vpc" "cluster_vpc"{
  tags = {
    Name = "das-vpc"
  }
}

data "aws_subnets" "private" {
  tags = {
    Name = "sub-euw2-dev-privAp-*"
  }
}

data "aws_subnet" "subnetid" {
  count = "${length(data.aws_subnets.private.ids)}"
  id = "${data.aws_subnets.private.ids[count.index]}"
}

#Instance Profile
resource "aws_iam_instance_profile" "iamprofile" {
  name = "iamprofile-ssm-ec2"
  role = "${aws_iam_role.das_role.id}"
}

#Attach Policies to Instance Role
resource "aws_iam_policy_attachment" "iamattach" {
  name       = "attachment"
  roles      = [aws_iam_role.das_role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy_attachment" "test_attach2" {
  name       = "attachment"
  roles      = [aws_iam_role.das_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

#EC2 Instance
resource "aws_instance" "das-ec2" { 
    count = "1"
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = "${element(data.aws_subnets.private.ids, count.index)}"
    vpc_security_group_ids = [aws_security_group.das_security.id]
    monitoring = "true"
    iam_instance_profile = "${aws_iam_instance_profile.iamprofile.id}"
    user_data = file("${path.module}/install-ssm.sh")

    tags = {
        Name = var.aws_instance_name
    }
}
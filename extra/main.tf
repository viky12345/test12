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
    Name = "newrole1311"
  }
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

resource "aws_instance" "das-ec2" { 
    count = "1"
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = "subnet-5e7a9a23"
    vpc_security_group_ids = ["sg-6e0a4a1c"]
    monitoring = "true"
    iam_instance_profile = "${aws_iam_instance_profile.iamprofile.id}"
    user_data = file("${path.module}/install-ssm.sh")

    tags = {
        Name = var.aws_instance_name
    }
}
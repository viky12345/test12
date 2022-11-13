# Local variables to
locals {
  # Sets count for allowed security groups
  security_ingress_group = length(var.allowed_security_groups)

  # Creates list of security groups to add
  ingress_group_list = setproduct(keys(var.azs), var.allowed_security_groups)

  # Joins additional security groups to documentDB security group
  joined_security_group = join("", aws_security_group.docdb.*.id)
}

# Create Security Group for DocumentDB

resource "aws_security_group" "docdb" {
  name        = var.product_identifier
  description = "Security Group for ${var.product_identifier}"
  # vpc_id      = var.vpc_id
  vpc_id = data.aws_vpc.cluster_vpc.id

tags ={
  Name=var.product_identifier
}

  # tags = merge(
  #   var.tags,
  #   {
  #     "Name" = var.product_identifier
  #   },
  # )
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.outgoing_cidrs
  security_group_id = local.joined_security_group
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count = local.security_ingress_group

  type                     = "ingress"
  description              = "Allow inbound traffic from existing Security Groups"
  from_port                = var.db_ingress_port
  to_port                  = var.db_ingress_port
  protocol                 = "tcp"
  source_security_group_id = local.ingress_group_list[count.index][1]
  security_group_id        = local.joined_security_group
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  type              = "ingress"
  description       = "Allow inbound traffic from CIDR blocks"
  from_port         = var.db_ingress_port
  to_port           = var.db_ingress_port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidrs
  security_group_id = local.joined_security_group
}

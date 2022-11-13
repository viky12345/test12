variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "backup retention period in days"
  type        = number
  default     = 7
}

variable "ca_cert_identifier" {
  description = "Optional, identifier of the CA certificate to use for DB instance"
  type        = string
  default     = "rds-ca-2019"
}

variable "cluster_instance_class" {
  description = "instance type"
  type        = string
  #default     = "db.r5.large"
}

variable "cluster_instance_count" {
  description = "size of cluster"
  type        = number
  #default     = 2
}

# variable "group_subnets" {
#   description = "subnets to be deployed in"
#   type        = list(string)
# }

variable "product_identifier" {
  description = "Unique identifier for product, and must be less than 25 characters"
  type        = string
  default     = "das-docdb"
}

variable "preferred_backup_window" {
  description = " preferred backup window"
  type        = string
  default     = "07:00-09:00"
}

variable "skip_final_snapshot" {
  description = "skip final snapshot on delete"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "encrypt storage"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "aws region to deploy in"
  type        = string
  #default     = "eu-west-2"
}

variable "family" {
  description = "Version of docdb family being created"
  type        = string
  #default     = "docdb3.6"
}

variable "engine" {
  description = "The name of the database engine to be used for this DB cluster. Only `docdb` is supported."
  type        = string
  #default     = "docdb"
}

variable "engine_version" {
  description = "The database engine version. Updating this argument results in an outage."
  type        = string
  #default     = "4.0.0"
}

variable "kms_key_id" {
  description = "KMS key arn to encrypt storage"
  type        = string
  default     = "alias/dwp-kms-generated"
}

variable "password_length" {
  description = "Length of password to create for DocumentDB master account"
  type        = number
  default     = 12
}

variable "username_length" {
  description = "Length of username to create for DocumentDB master account"
  type        = number
  default     = 8
}

variable "ssm_environment" {
  description = "Used for storing parameters in ssm"
  type        = string
  default     = "das-docdb"
}

variable "cloudwatch_logs_to_export" {
  description = "Log types to export to cloudwatch"
  type        = list(string)
  default     = ["audit"]
}

#variable "zone_id" {
  #description = "route53 zone id for cluster"
  #type        = string
#}

# variable "vpc_id" {
#   description = "VPC id to deploy in"
#   type        = string
# }

variable "db_ingress_port" {
  description = "Ingress port to documentdb"
  type        = string
  default     = "27017"
}

variable "allowed_cidrs" {
  description = "Allowed incoming cidrs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "outgoing_cidrs" {
  description = "Allowed outgoing cidrs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Standard map of tags to assign to documentdb resources. { tag_name = tag_value }"
  type        = any
  default     = "documentdb"
}

variable "allowed_security_groups" {
  description = "List of security groups to add to allow access to documentdb . If not defined, no security group will be created."
  type        = list(string)
  #default     = []
}

variable "azs" {
  description = "Availability zone for region, used to create list of cidrs"
  type        = map(string)

  default = {
    a = "eu-west-2a"
    b = "eu-west-2b"
    c = "eu-west-2c"
  #}
}

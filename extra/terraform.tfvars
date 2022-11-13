sg_ingress_rules = {
  "1" = {
    from_port   = 27017	
    to_port     = 27017	
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Documentdb"
  },
  "2" = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  "3" = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }
}
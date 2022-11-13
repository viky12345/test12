data "aws_route53_zone" "zone_name" {
    name = "sce-dev-voc.dwpcloud.uk"
    private_zone=false

}

# Create Route53 entry for DocumentDB cluster
resource "aws_route53_record" "docdb_private_record" {
  name    = var.product_identifier
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone_name.zone_id
  ttl     = 300
  records = [aws_docdb_cluster.docdb_cluster.endpoint]
}

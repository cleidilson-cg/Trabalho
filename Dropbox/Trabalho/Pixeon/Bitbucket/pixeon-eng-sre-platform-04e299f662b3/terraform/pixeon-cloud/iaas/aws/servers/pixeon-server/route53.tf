/* Pixeon Server Instance DNS Register */

data "aws_route53_zone" "pixeon_public_zone" {
  name         = "pixeon.cloud."
  private_zone = false
}

resource "aws_route53_record" "pixeon_server_public_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_public_zone.zone_id}"
  name    = "${var.stack_name}${var.stack_env != "prod" ? "-${var.stack_env}" : ""}.${data.aws_route53_zone.pixeon_public_zone.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_instance.pixeon_server.public_dns}"]
} 

resource "aws_route53_record" "pixeon_server_private_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_public_zone.zone_id}"
  name    = "jiradb.${var.stack_env != "prod" ? "${var.stack_env}" : ""}.${data.aws_route53_zone.pixeon_public_zone.name}"
  type    = "CNAME"
  ttl     = "30"
  records = ["${aws_db_instance.pixeoninstance.address}"]
} 
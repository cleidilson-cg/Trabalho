/* VPN Instance DNS Register */
/*
resource "aws_route53_record" "vpn_public_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_public_zone.zone_id}"
  name    = "vpn.${data.aws_route53_zone.pixeon_public_zone.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elb.ranche_elb.dns_name}"]
}
*/


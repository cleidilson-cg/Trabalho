
/* Route53 Register for Openvpn */

data "aws_route53_zone" "pixeon_server_public_dns" {
  name = "${local.domain_zone}"
  private_zone = false
}


resource "aws_route53_record" "pixeon_server_public_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_server_public_dns.zone_id}"
  name    = "vpn.${data.aws_route53_zone.pixeon_server_public_dns.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.pixeon_server.public_ip}"]
}

resource "aws_route53_record" "pixeon_server_private_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_server_public_dns.zone_id}"
  name    = "vpn.intra.${data.aws_route53_zone.pixeon_server_public_dns.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.pixeon_server.private_ip}"]
}


resource "aws_route53_record" "pixeon_server_public_dev_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_server_public_dns.zone_id}"
  name    = "vpn.dev.${data.aws_route53_zone.pixeon_server_public_dns.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.pixeon_server.public_ip}"]
}

/* Rancher Instance DNS Register */

resource "aws_route53_record" "rancher_public_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_public_zone.zone_id}"
  name    = "caas2.${data.aws_route53_zone.pixeon_public_zone.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elb.rancher_elb.dns_name}"]
}

/* Rancher DB DNS Register */

resource "aws_route53_record" "rancher_db_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_public_zone.zone_id}"
  name    = "caas2db.${data.aws_route53_zone.pixeon_public_zone.name}"
  type    = "CNAME"
  ttl     = "30"
  records = ["${aws_rds_cluster.db_cluster.endpoint}"]
}

/* Ansilble DNS Register */


/*

resource "aws_route53_record" "ansible_public_dns" {
  zone_id = "${data.aws_route53_zone.pixeon_public_zone.zone_id}"
  name = "ansible.${data.aws_route53_zone.pixeon_public_zone.name}"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elb.ansible_elb.dns_name}"]
}

*/


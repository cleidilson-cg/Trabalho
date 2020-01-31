data "aws_route53_zone" "selected" {
    name         = "${var.domain_zone}."#"pixeon.cloud."
    private_zone = false
}

resource "aws_route53_record" "korus_dns" {
    count = "${var.route53_count_records_dns}"
    
    zone_id = "${data.aws_route53_zone.selected.zone_id}"
    name    = "${lookup(var.route53_records_dns[count.index], "dns_name")}"
    type    = "${lookup(var.route53_records_dns[count.index], "dns_type")}"
    ttl     = "300"
    records = ["${lookup(var.route53_records_dns[count.index], "records")}"]

    lifecycle {
        create_before_destroy = true
    }
}


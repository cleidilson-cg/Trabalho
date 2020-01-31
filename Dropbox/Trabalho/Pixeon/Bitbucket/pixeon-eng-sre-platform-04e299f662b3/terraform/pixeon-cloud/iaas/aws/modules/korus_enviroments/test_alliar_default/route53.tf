/* Route53 to System Korus */
module "korus_route53" {
    source = "../../korus_route53"

    aws_region = "${var.aws_region}"
    aws_profile = "pixeon"
    domain_zone = "${var.domain_zone}"
    route53_count_records_dns = "${length(var.route53_records_dns)}"
    route53_records_dns = "${var.route53_records_dns}"
    name_all = "${var.name_all}"

    stack_name="${var.stack_name}_route53"
    stack_env="${var.stack_env}"
    squad="${var.squad}"
    
}
/* Route53 to System Korus */
module "korus_route53" {
    source = "../../korus_route53"

    aws_region = "${var.aws_region}"
    aws_profile = "${var.aws_profile}"

    route53_count_records_dns = 2
    route53_records_dns = [
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "webcloud.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "apicloud.${var.host_header}"
        },
    ]

    stack_name="${var.stack_name}_route53"
    stack_env="${var.stack_env}"
    squad="${var.squad}"
    
}
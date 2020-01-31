/* Route53 to Redis Korus */
module "korus_route53_rundeck_slave_win" {
    source = "../../modules/korus_route53"

    aws_region = "${local.aws_region}"
    aws_profile = "${local.aws_profile}"
    domain_zone = "${local.domain_zone}"

    route53_type="A"

    route53_count_records_dns = 1
    route53_records_dns = [
        {
        records         = "${module.rundeck_slave_win.private_ip}"
        dns_name        = "rundeck.slave.win.internal.${local.stack_env}.${local.domain_zone}"
        }
    ]

    stack_name="${local.stack_name}_route53_rundeck"
    stack_env="${local.stack_env}"
    squad="${local.squad}"
    
}
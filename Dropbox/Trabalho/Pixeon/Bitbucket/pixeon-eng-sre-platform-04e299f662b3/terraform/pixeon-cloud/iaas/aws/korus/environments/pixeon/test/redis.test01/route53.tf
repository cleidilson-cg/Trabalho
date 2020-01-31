/* Route53 to Redis Korus */
module "korus_route53_redis" {
    source = "../../../modules/korus_route53"

    aws_region = "${local.aws_region}"
    aws_profile = "${local.aws_profile}"
    domain_zone = "${local.domain_zone}"

    domain_zone="${local.domain_zone}"

    route53_count_records_dns = 1
    route53_records_dns = [
        {
        records         = "${module.korus_redis_tst.redis_primary_endpoint_address}"
        dns_name        = "redis.${local.stack_env}.${local.domain_zone}"
        }
    ]

    stack_name="${local.stack_name}_route53_redis"
    stack_env="${local.stack_env}"
    squad="${local.squad}"
    
}
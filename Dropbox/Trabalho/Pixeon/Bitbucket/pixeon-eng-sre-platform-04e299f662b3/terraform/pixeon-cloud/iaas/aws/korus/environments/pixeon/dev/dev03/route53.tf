/* Route53 to System Korus */
module "korus_route53" {
    source = "../../../modules/korus_route53"

    aws_region = "${local.aws_region}"
    aws_profile = "${local.aws_profile}"

    route53_records_dns = [
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "home-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "pleres-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "sac-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "bussola-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "questionario-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "wcf-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "agendamento-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "rol-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "painelsenha-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "mobile-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "central-ws-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "apoiado-api-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "apoiado-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "documento-api-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "laudo-api-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "relatorio-api-${local.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "central-${local.host_header}"
        },
    ]

    stack_name="${local.stack_name}_route53"
    stack_env="${local.stack_env}"
    squad="${local.squad}"
    
}
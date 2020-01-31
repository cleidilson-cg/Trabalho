/* Route53 to System Korus */
module "korus_route53" {
    source = "../../korus_route53"

    aws_region = "${var.aws_region}"
    aws_profile = "${var.aws_profile}"
    domain_zone = "${var.domain_zone}"

    domain_zone="${var.domain_zone}"

    route53_count_records_dns = 20
    route53_records_dns = [
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "home.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "pleres.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "sac.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "bussola.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "questionario.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "wcf.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "agendamento.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "rol.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "painelsenha.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "mobile.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "centralws.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "apoiadoapi.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "apoiado.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "documentoapi.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "laudoapi.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "relatorioapi.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "central.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "dev.${var.domain_zone}"
        dns_name        = "wcfauth.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "dev.${var.domain_zone}"
        dns_name        = "wcfrelatorio.${var.name_all}.${var.domain_zone}"
        },
        {
        records         = "dev.${var.domain_zone}"
        dns_name        = "cep.${var.name_all}.${var.domain_zone}"
        }

    ]

    stack_name="${var.stack_name}_route53"
    stack_env="${var.stack_env}"
    squad="${var.squad}"
    
}
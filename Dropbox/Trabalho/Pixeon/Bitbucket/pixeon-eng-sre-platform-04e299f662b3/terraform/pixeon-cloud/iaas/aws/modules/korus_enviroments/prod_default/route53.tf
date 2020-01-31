/* Route53 to System Korus */
module "korus_route53" {
    source = "../../korus_route53"

    aws_region = "${var.aws_region}"
    aws_profile = "${var.aws_profile}"

    route53_count_records_dns = 17
    route53_records_dns = [
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "home.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "pleres.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "sac.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "bussola.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "questionario.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "wcf.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "agendamento.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "rol.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "painelsenha.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "mobile.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "centralws.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "apoiadoapi.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "apoiado.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "documentoapi.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "laudoapi.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "relatorioapi.${var.host_header}"
        },
        {
        records         = "${module.korus_alb_external.load_balancer_dns_name}"
        dns_name        = "central.${var.host_header}"
        },
    ]

    stack_name="${var.stack_name}_route53"
    stack_env="${var.stack_env}"
    squad="${var.squad}"
    
}
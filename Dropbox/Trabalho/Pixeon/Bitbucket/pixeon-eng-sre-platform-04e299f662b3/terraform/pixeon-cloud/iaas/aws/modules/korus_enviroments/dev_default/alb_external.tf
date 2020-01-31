/* Load Balancer External System Korus*/
module "korus_alb_external" {
  source = "../../korus_alb"

  aws_region          = "${var.aws_region}"
  aws_profile         = "${var.aws_profile}"
  name                = "${var.lb_name}"
  internal            = "false"
  
  certificate_arn = "${module.korus_acm.cert_arn}"

  listeners = [
    {
      port = "443"
      protocol = "HTTPS"
    }
  ]

  #target_id_frontend    = ["${concat(module.korus_web_front_a.instances_id, module.korus_web_front_b.instances_id)}"]
  target_id_frontend_A  = ["${module.korus_web_front_a.instances_id}"]
  target_id_frontend_B  = []
  target_id_backend_A   = []
  target_id_backend_B   = []
  target_id_winservices = []
  
  target_groups_frontend = [
    {
      target_port     = "8800"
      target_group    = "${var.lb_name}-home"
      host_header     = "home.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8801"
      target_group    = "${var.lb_name}-pleres"
      host_header     = "pleres.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8802"
      target_group    = "${var.lb_name}-sac"
      host_header     = "sac.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8803"
      target_group    = "${var.lb_name}-bussola"
      host_header     = "bussola.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8804"
      target_group    = "${var.lb_name}-questio"
      host_header     = "questionario.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8805"
      target_group    = "${var.lb_name}-wcf"
      host_header     = "wcf.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8806"
      target_group    = "${var.lb_name}-agend"    
      host_header     = "agendamento.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8807"
      target_group    = "${var.lb_name}-rol"
      host_header     = "rol.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8808"
      target_group    = "${var.lb_name}-painel"
      host_header     = "painelsenha.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8809"
      target_group    = "${var.lb_name}-mobile"
      host_header     = "mobile.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8810"
      target_group    = "${var.lb_name}-cent-ws"
      host_header     = "centralws.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8811"
      target_group    = "${var.lb_name}-apoi-api"
      host_header     = "apoiadoapi.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8812"
      target_group    = "${var.lb_name}-apoi"
      host_header     = "apoiado.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8813"
      target_group    = "${var.lb_name}-documento-api"
      host_header     = "documentoapi.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8814"
      target_group    = "${var.lb_name}-laudo-api"
      host_header     = "laudoapi.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8815"
      target_group    = "${var.lb_name}-relatorio-api"
      host_header     = "relatorioapi.${var.name_all}.${var.domain_zone}"
    },
    {
      target_port     = "8816"
      target_group    = "${var.lb_name}-cent"
      host_header     = "central.${var.name_all}.${var.domain_zone}"
    },
    
  ]

  target_groups_backend = [
    
    
  ]

  target_groups_winservices = [
    
  ]

  stack_name          = "${var.stack_name}"
  stack_env           = "${var.stack_env}"
  squad               = "${var.squad}"

  tags = {
      Name            = "${var.name_all}"
      Creation-Tool   = "terraform"
      Env             = "${var.stack_env}"
      Squad           = "${var.squad}"
  }
}

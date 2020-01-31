/* Load Balancer External System Korus*/
module "korus_alb_external" {
  source = "../../korus_alb"

  aws_region          = "${var.aws_region}"
  aws_profile         = "${var.aws_profile}"
  name                = "${var.lb_name}"
  internal            = "false"
  
  certificate_arn = ""

  listeners = [
    {
      port = "443"
      protocol = "HTTPS"
    }
  ]

  #target_id_frontend    = ["${concat(module.korus_web_front_a.instances_id, module.korus_web_front_b.instances_id)}"]
  target_id_frontend_A  = ["${module.korus_web_front_a.instances_id}"]
  target_id_frontend_B  = ["${module.korus_web_front_b.instances_id}"]
  target_id_backend_A   = ["${module.korus_web_back_a.instances_id}"]
  target_id_backend_B   = ["${module.korus_web_back_b.instances_id}"]
  target_id_winservices = ["${module.korus_winservices.instances_id}"]
  
  target_groups_frontend = [
    {
      target_port     = "8800"
      target_group    = "${var.lb_name}-home"
      host_header     = "home.${var.host_header}"
    },
    {
      target_port     = "8801"
      target_group    = "${var.lb_name}-pleres"
      host_header     = "pleres.${var.host_header}"
    },
    {
      target_port     = "8802"
      target_group    = "${var.lb_name}-sac"
      host_header     = "sac.${var.host_header}"
    },
    {
      target_port     = "8803"
      target_group    = "${var.lb_name}-bussola"
      host_header     = "bussola.${var.host_header}"
    },
    {
      target_port     = "8804"
      target_group    = "${var.lb_name}-questio"
      host_header     = "questionario.${var.host_header}"
    },
    {
      target_port     = "8806"
      target_group    = "${var.lb_name}-agend"    
      host_header     = "agendamento.${var.host_header}"
    },
    {
      target_port     = "8807"
      target_group    = "${var.lb_name}-rol"
      host_header     = "rol.${var.host_header}"
    },
    {
      target_port     = "8809"
      target_group    = "${var.lb_name}-mobile"
      host_header     = "mobile.${var.host_header}"
    },
    {
      target_port     = "8810"
      target_group    = "${var.lb_name}-cent-ws"
      host_header     = "centralws.${var.host_header}"
    },
    {
      target_port     = "8811"
      target_group    = "${var.lb_name}-apoi-api"
      host_header     = "apoiadoapi.${var.host_header}"
    },
    {
      target_port     = "8812"
      target_group    = "${var.lb_name}-apoi"
      host_header     = "apoiado.${var.host_header}"
    },
    {
      target_port     = "8816"
      target_group    = "${var.lb_name}-cent"
      host_header     = "central.${var.host_header}"
    },
    
  ]

  target_groups_backend = [
    {
      target_port     = "8805"
      target_group    = "${var.lb_name}-wcf"
      host_header     = "wcf.${var.host_header}"
    },
    {
      target_port     = "8813"
      target_group    = "${var.lb_name}-documento-api"
      host_header     = "documentoapi.${var.host_header}"
    },
    {
      target_port     = "8814"
      target_group    = "${var.lb_name}-laudo-api"
      host_header     = "laudoapi.${var.host_header}"
    },
    {
      target_port     = "8815"
      target_group    = "${var.lb_name}-relatorio-api"
      host_header     = "relatorioapi.${var.host_header}"
    },
  ]

  target_groups_winservices = [
    {
      target_port     = "8808"
      target_group    = "${var.lb_name}-painel"
      host_header     = "painelsenha.${var.host_header}"
    },
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

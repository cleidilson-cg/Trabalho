/* Load Balancer External System Korus*/
module "korus_alb_external" {
  source = "../../../modules/korus_alb"

  aws_region          = "${local.aws_region}"
  aws_profile         = "${local.aws_profile}"
  name                = "${local.lb_name}"
  internal            = "false"

  certificate_arn = "${local.lb_certificate_arn}"

  # dns_zone = "pixeon.cloud"
  # dns_lb = "lb-korus-vg.dev"
  # dns_alias_lb = ["korus.dev", "korus2.dev"]

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
      target_group    = "${local.lb_name}-home"
      host_header     = "home-${local.host_header}"
    },
    {
      target_port     = "8801"
      target_group    = "${local.lb_name}-pleres"
      host_header     = "pleres-${local.host_header}"
    },
    {
      target_port     = "8802"
      target_group    = "${local.lb_name}-sac"
      host_header     = "sac-${local.host_header}"
    },
    {
      target_port     = "8803"
      target_group    = "${local.lb_name}-bussola"
      host_header     = "bussola-${local.host_header}"
    },
    {
      target_port     = "8804"
      target_group    = "${local.lb_name}-questionario"
      host_header     = "questionario-${local.host_header}"
    },
    {
      target_port     = "8806"
      target_group    = "${local.lb_name}-agendamento"    
      host_header     = "agendamento-${local.host_header}"
    },
    {
      target_port     = "8807"
      target_group    = "${local.lb_name}-rol"
      host_header     = "rol-${local.host_header}"
    },
    {
      target_port     = "8809"
      target_group    = "${local.lb_name}-mobile"
      host_header     = "mobile-${local.host_header}"
    },
    {
      target_port     = "8810"
      target_group    = "${local.lb_name}-central-ws"
      host_header     = "central-ws-${local.host_header}"
    },
    {
      target_port     = "8811"
      target_group    = "${local.lb_name}-apoiado-api"
      host_header     = "apoiado-api-${local.host_header}"
    },
    {
      target_port     = "8812"
      target_group    = "${local.lb_name}-apoiado"
      host_header     = "apoiado-${local.host_header}"
    },
    {
      target_port     = "8816"
      target_group    = "${local.lb_name}-central"
      host_header     = "central-${local.host_header}"
    },
  ]

  target_groups_backend = [
    {
      target_port     = "8805"
      target_group    = "${local.lb_name}-wcf"
      host_header     = "wcf-${local.host_header}"
    },
    {
      target_port     = "8813"
      target_group    = "${local.lb_name}-documento-api"
      host_header     = "documento-api-${local.host_header}"
    },
    {
      target_port     = "8814"
      target_group    = "${local.lb_name}-laudo-api"
      host_header     = "laudo-api-${local.host_header}"
    },
    {
      target_port     = "8815"
      target_group    = "${local.lb_name}-relatorio-api"
      host_header     = "relatorio-api-${local.host_header}"
    },
  ]

  target_groups_winservices = [
    {
      target_port     = "8808"
      target_group    = "${local.lb_name}-painelsenha"
      host_header     = "painelsenha-${local.host_header}"
    },
  ]

  stack_name          = "${local.stack_name}"
  stack_env           = "${local.stack_env}"
  squad               = "${local.squad}"

  tags = {
      Name            = "${local.name_all}"
      Creation-Tool   = "terraform"
      Env             = "${local.stack_env}"
      Squad           = "${local.squad}"
  }
}

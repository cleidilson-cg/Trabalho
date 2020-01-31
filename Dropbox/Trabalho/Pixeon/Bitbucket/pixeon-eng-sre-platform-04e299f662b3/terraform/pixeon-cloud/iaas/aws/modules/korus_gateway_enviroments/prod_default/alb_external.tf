/* Load Balancer External System Korus*/
module "korus_alb_external" {
  source = "../../korus_alb"

  aws_region          = "${var.aws_region}"
  aws_profile         = "${var.aws_profile}"
  name                = "${var.lb_name}"
  internal            = "false"
  
  certificate_arn = "${var.lb_certificate_arn}"

  listeners = [
    {
      port = "443"
      protocol = "HTTPS"
    }
  ]

  target_id_frontend_A  = ["${module.korus_web_front_a.instances_id}"]
  target_id_frontend_B  = [""]
  target_id_backend_A   = [""]
  target_id_backend_B   = [""]
  target_id_winservices = [""]
  
  target_groups_frontend = [
    {
      target_port     = "8800"
      target_group    = "${var.lb_name}-webcloud"
      host_header     = "webcloud.${var.host_header}"
    },
    {
      target_port     = "8801"
      target_group    = "${var.lb_name}-apicloud"
      host_header     = "apicloud.${var.host_header}"
    },
    
  ]

  target_groups_backend = []
  target_groups_winservices = []

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

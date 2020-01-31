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
  target_id_frontend_B  = ["${module.korus_web_front_b.instances_id}"]
  target_id_backend_A   = []
  target_id_backend_B   = []
  target_id_winservices = []
  target_groups_frontend = "${var.target_groups_frontend}"
  
  target_groups_backend = [
    
    
  ]

  target_groups_winservices = [
    
  ]

  stack_vpc = "${var.stack_vpc}"
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

resource "aws_route53_record" "korus_alb_record" {    
    zone_id = "${data.aws_route53_zone.selected.zone_id}"
    name    = "alb.${var.name_all}.${var.domain_zone}"
    type    = "CNAME"
    ttl     = "300"
    records = ["${module.korus_alb_external.load_balancer_dns_name}"]
    provider = "aws.pixeon-aws"
    lifecycle {
        create_before_destroy = true
    }
}


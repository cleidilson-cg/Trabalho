/* Load Balancer */
module "korus_lb_dev" {
  source = "../../../modules/korus_alb"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name = "lb-${local.name_all}-vg"
  # environment = "dev"
  # load_balancer_type = "application"
  # dns_zone = "pixeon.cloud"
  # dns_lb = "lb-korus-vg.dev"
  # dns_alias_lb = ["korus.dev", "korus2.dev"]
  # ec2_tags = {
  #   Env = "dev"
  #   App = "korus"
    
  # }
  # listeners = [
  #   {
  #     port = "8080"
  #     target_port = "8080"
  #     target_group = "korus-dev"
  #   }
  # ]
  # internal = "false"

  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"
}

module "nlb" {
  source = "../../../../../../modules/ec2/nlb/"

  aws_region    = "us-east-1"
  aws_profile   = "pixeon-account"
  name          = "nlb-pixeon-vg"
  environment   = "dev"
  dns_zone      = "pixeon.cloud"
  dns_nlb       = "nlb-pixeon-vg.dev"
  dns_alias_nlb = ["fluentd.dev"]

  subnet_tags = {
    Env  = "dev"
    Tier = "public"
  }

  ec2_tags = {
    Env = "dev"
    App = "rancher"
  }

  listeners = [
    {
      port         = "24224"
      target_port  = "24224"
      target_group = "fluentd-dev"
    },
  ]

  internal = "false"
  vpc_id   = "vpc-0c6f95e57844262bb"
}

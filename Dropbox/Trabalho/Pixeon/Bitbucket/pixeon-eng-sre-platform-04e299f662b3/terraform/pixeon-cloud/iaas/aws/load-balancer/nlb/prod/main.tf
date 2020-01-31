module "nlb" {
  source = "../../../../../../modules/ec2/nlb/"

  aws_region    = "sa-east-1"
  aws_profile   = "pixeon-account"
  name          = "nlb-pixeon-sp"
  environment   = "prod"
  dns_zone      = "pixeon.cloud"
  dns_nlb       = "nlb-pixeon-sa"
  dns_alias_nlb = ["fluentd"]

  subnet_tags = {
    Env  = "prod"
    Tier = "public"
  }

  ec2_tags = {
    Env = "prod"
    App = "rancher"
  }

  listeners = [
    {
      port         = "24224"
      target_port  = "24224"
      target_group = "fluentd-prod"
    },
  ]

  internal = "false"
  vpc_id   = "vpc-eaea7b8f"
}

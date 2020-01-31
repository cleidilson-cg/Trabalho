module "korus_acm" {
  source = "../../korus_acm"

  aws_region = "${var.aws_region}"
  aws_profile = "${var.aws_profile}"
  
  domain_zone = "${var.domain_zone}"
  
  stack_name="${var.stack_name}"
  stack_env="${var.stack_env}"
  squad="${var.squad}"

}

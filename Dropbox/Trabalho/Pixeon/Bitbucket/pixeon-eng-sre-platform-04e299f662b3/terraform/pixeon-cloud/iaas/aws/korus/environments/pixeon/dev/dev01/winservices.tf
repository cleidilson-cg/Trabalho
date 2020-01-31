/* EC2 Winservices */
module "korus_winservices_dev" {
  source = "../../../modules/korus_winservices"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}_winservices"
  amazon_machine_image="ami-05f5c28bb6992ab4b"
  
  volume_size=50
  server_instance_type="t2.large"
  server_port="8080"

  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

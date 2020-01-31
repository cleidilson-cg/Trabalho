/* Server Winservices to System Korus */
module "korus_winservices" {
  source = "../../../modules/korus_winservices"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}_winservices"
  amazon_machine_image="${local.amazon_machine_image_winservices}"
  
  volume_size=80
  server_instance_type="${local.instance_type_winservices}"
  korus_from_port="${local.korus_from_port}"
  korus_to_port="${local.korus_to_port}"

  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

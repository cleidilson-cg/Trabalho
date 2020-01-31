/* Server Frontend A to System Korus */
module "korus_web_front_a" {
  source = "../../../modules/korus_web"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}_front_a" 
  instance_count="1"
  amazon_machine_image="${local.amazon_machine_image_front_A}"
  
  volume_size=80
  server_instance_type="${local.instance_type_back}"
  korus_from_port="${local.korus_from_port}"
  korus_to_port="${local.korus_to_port}"

  subnet_id="${data.aws_subnet_ids.private.ids[0]}"

  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

/* Server Frontend B to System Korus */
module "korus_web_front_b" {
  source = "../../../modules/korus_web"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}_front_b"
  instance_count="1"
  amazon_machine_image="${local.amazon_machine_image_front_B}"
  
  volume_size=80
  server_instance_type="${local.instance_type_back}"
  korus_from_port="${local.korus_from_port}"
  korus_to_port="${local.korus_to_port}"

  subnet_id="${data.aws_subnet_ids.private.ids[1]}"

  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

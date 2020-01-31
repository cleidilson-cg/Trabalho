/* Korus web front A */
module "korus_web_front_a" {
  source = "../../../modules/korus_web"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}_front_a"
  
  instance_count="1"

  lb_name=""#"${module.korus_lb_dev.lb_name}"
  amazon_machine_image="${local.amazon_machine_image_front}"
  
  volume_size=80
  server_instance_type="t2.large"
  server_port="8080"

  scaling_min_size="1"
  scaling_max_size="2"

  subnet_id="${data.aws_subnet_ids.private.ids[0]}"

  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

/* Korus web front B */
module "korus_web_front_b" {
  source = "../../../modules/korus_web"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}_front_b"
  
  instance_count="1"

  lb_name=""#"${module.korus_lb_dev.lb_name}"
  amazon_machine_image="${local.amazon_machine_image_front}"
  
  volume_size=80
  server_instance_type="t2.large"
  server_port="8080"

  scaling_min_size="1"
  scaling_max_size="2"

  subnet_id="${data.aws_subnet_ids.private.ids[1]}"

  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

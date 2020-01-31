/* Server Frontend A to System Korus */
module "korus_web_front_a" {
  source = "../../korus_web"

  aws_region = "${var.aws_region}"
  aws_profile = "${var.aws_profile}"
  name="${var.name_all}_front_a" 
  instance_count="1"
  ami="${var.ami_front_A}"
  
  volume_size=80
  server_instance_type="${var.instance_type_front}"
  korus_from_port="${var.korus_from_port}"
  korus_to_port="${var.korus_to_port}"

  subnet_id="${data.aws_subnet_ids.private.ids[0]}"

  stack_name="${var.stack_name}"
  stack_env="${var.stack_env}"
  squad="${var.squad}"

  ## Chef
  chef_environment     = "${var.chef_environment}"
  chef_run_list        = ["${var.chef_run_list}"]
  chef_node_name       = "${var.name_all}_front_a" 
  chef_server_url      = "${var.chef_server_url}"
  chef_user_name       = "${var.chef_user_name}"
  chef_recreate_client = "${var.chef_recreate_client}"
  chef_user_key        = "${var.chef_user_key}"
  chef_attributes_json = "${var.chef_attributes_json}"
  chef_connection_type = "${var.chef_connection_type}"
  chef_connection_user = "${var.chef_connection_user}"
  chef_connection_password = "${var.chef_connection_password}"
}
/* Server Frontend B to System Korus */
module "korus_web_front_b" {
  source = "../../../modules/korus_web"

  aws_region = "${var.aws_region}"
  aws_profile = "${var.aws_profile}"
  name="${var.name_all}_front_b"
  instance_count="1"
  ami="${var.ami_front_B}"
  
  volume_size=80
  server_instance_type="${var.instance_type_front}"
  korus_from_port="${var.korus_from_port}"
  korus_to_port="${var.korus_to_port}"

  subnet_id="${data.aws_subnet_ids.private.ids[1]}"

  stack_name="${var.stack_name}"
  stack_env="${var.stack_env}"
  squad="${var.squad}"

  ## Chef
  chef_environment     = "${var.chef_environment}"
  chef_run_list        = ["${var.chef_run_list}"]
  chef_node_name       = "${var.name_all}_front_b" 
  chef_server_url      = "${var.chef_server_url}"
  chef_user_name       = "${var.chef_user_name}"
  chef_recreate_client = "${var.chef_recreate_client}"
  chef_user_key        = "${var.chef_user_key}"
  chef_attributes_json = "${var.chef_attributes_json}"
  chef_connection_type = "${var.chef_connection_type}"
  chef_connection_user = "${var.chef_connection_user}"
  chef_connection_password = "${var.chef_connection_password}"

}
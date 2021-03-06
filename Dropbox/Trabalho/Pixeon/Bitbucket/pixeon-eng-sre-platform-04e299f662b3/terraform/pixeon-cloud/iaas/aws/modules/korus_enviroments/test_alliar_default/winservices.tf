/* Server Frontend A to System Korus */
module "korus_windows_services" {
  source = "../../korus_winservices"

  aws_region = "${var.aws_region}"
  aws_profile = "${var.aws_profile}"
  name="${var.name_all}-winservices"
  name_all="${var.name_all}"
  #instance_count="1"
  ami="${var.ami_winservices}"
  domain_zone="${var.domain_zone}"
  
  volume_size=80
  server_instance_type="${var.instance_type_winservices}"
  korus_from_port="${var.korus_from_port}"
  korus_to_port="${var.korus_to_port}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  assign_eip_address = "${var.assign_eip_address}"
  subnet_id="${data.aws_subnet_ids.private.ids[2]}"

  stack_vpc = "${var.stack_vpc}"
  stack_name="${var.stack_name}"
  stack_env="${var.stack_env}"
  squad="${var.squad}"

  ## Chef
  chef_environment     = "${var.chef_environment}"
  chef_run_list        = ["${var.chef_run_list}"]
  chef_node_name       = "${var.name_all}-winservices" 
  chef_server_url      = "${var.chef_server_url}"
  chef_user_name       = "${var.chef_user_name}"
  chef_recreate_client = "${var.chef_recreate_client}"
  chef_user_key        = "${var.chef_user_key}"
  chef_attributes_json = "${var.chef_attributes_json_winservices}"
  chef_connection_type = "${var.chef_connection_type}"
  chef_connection_user = "${var.chef_connection_user}"
  chef_connection_password = "${var.chef_connection_password}"
  chef_rerun="${var.chef_rerun}"
}
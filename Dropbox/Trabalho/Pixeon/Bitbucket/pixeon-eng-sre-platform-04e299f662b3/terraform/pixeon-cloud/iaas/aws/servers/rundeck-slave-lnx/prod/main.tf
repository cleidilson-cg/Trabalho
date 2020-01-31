terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${local.aws_region}"
  profile = "${local.aws_profile}"
  version = "~> 1.46"
}

module "rundeck_slave_lnx" {
  source                  = "../../../modules/terraform-aws-ec2-instance"
  # source                  = "terraform-aws-modules/ec2-instance/aws"
  # version                 = "1.12.0"

  name                    = "${upper(local.name_all)}"
  instance_count          = "1"

  ami                     = "${local.ami}"
  instance_type           = "${local.instance_type}"
  key_name                = "pixeon-cloud-${local.stack_env}"
  monitoring              = true
  vpc_security_group_ids  = ["${aws_security_group.instance.id}"]
  subnet_id               = "${data.aws_subnet_ids.private.ids[0]}"
  
  root_block_device = [{
    delete_on_termination = true
    volume_type           = "gp2"
    volume_size           = "${local.volume_size}"
  }]
  
  tags {
    Name = "${upper(local.name_all)}"
    Creation-Tool = "terraform"
    Env = "${local.stack_env}"
    Squad = "${local.squad}"
  }

  ## Chef
  chef_environment     = "${local.chef_environment}"
  chef_run_list        = ["${local.chef_run_list}"]
  chef_node_name       = "${upper(local.name_all)}"
  chef_server_url      = "${local.chef_server_url}"
  chef_user_name       = "${local.chef_user_name}"
  chef_recreate_client = "${local.chef_recreate_client}"
  chef_user_key        = ""
  chef_attributes_json = "${local.chef_attributes_json}"
  chef_connection_type = "${local.chef_connection_type}"
  chef_connection_user = "${local.chef_connection_user}"
  chef_connection_password = "${local.chef_connection_password}"
  chef_rerun="${local.chef_rerun}"
}

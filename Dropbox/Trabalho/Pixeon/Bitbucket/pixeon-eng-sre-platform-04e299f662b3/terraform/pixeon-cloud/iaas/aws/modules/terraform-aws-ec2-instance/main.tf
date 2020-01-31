####################
#version = "1.12.0"

locals {
  is_t_instance_type = "${replace(var.instance_type, "/^t[23]{1}\\..*$/", "1") == "1" ? "1" : "0"}"
}

######
# Note: network_interface can't be specified together with associate_public_ip_address
######
resource "aws_instance" "this" {
  count = "${var.instance_count * (1 - local.is_t_instance_type)}"

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  iam_instance_profile   = "${var.iam_instance_profile}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  #assign_eip_address          = "${var.assign_eip_address}"
  private_ip                  = "${var.private_ip}"
  ipv6_address_count          = "${var.ipv6_address_count}"
  ipv6_addresses              = "${var.ipv6_addresses}"

  ebs_optimized          = "${var.ebs_optimized}"
  volume_tags            = "${var.volume_tags}"
  root_block_device      = "${var.root_block_device}"
  ebs_block_device       = "${var.ebs_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"

  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  placement_group                      = "${var.placement_group}"
  tenancy                              = "${var.tenancy}"

  tags = "${merge(var.tags, map("Name", var.instance_count > 1 ? format("%s-%d", var.name, count.index+1) : var.name))}"

  lifecycle {
    # Due to several known issues in Terraform AWS provider related to arguments of aws_instance:
    # (eg, https://github.com/terraform-providers/terraform-provider-aws/issues/2036)
    # we have to ignore changes in the following arguments
    ignore_changes = ["private_ip", "root_block_device", "ebs_block_device", "subnet_id"]
  }

  ###########
  ## Custom #
  ###########
  provisioner "chef" {
    environment     = "${var.chef_environment}"
    run_list        = ["${var.chef_run_list}"]
    node_name       = "${upper(var.name)}"
    server_url      = "${var.chef_server_url}"
    user_name       = "sre"
    recreate_client = "${var.chef_recreate_client}"
    user_key        = "${file("../../../../../chef/sre.pem")}"
    #secret_key      = "${file("~/.chef/encrypted_data_bag_secret")}"
    #version         = "${var.chef_version}"
    
    #on_failure      = "continue"

    attributes_json = "${var.chef_attributes_json}"

    connection {
      type                = "${var.chef_connection_type}"
      user                = "${var.chef_connection_user}"
      password            =  "${var.chef_connection_password}"
      #private_key         = "${file("~/.ssh/pixeon-cloud-${var.stack_env}.pem")}"
      # bastion_user        = "centos"
      # bastion_host        = "${data.aws_instance.bastion.private_ip}"
      # bastion_private_key = "${file("~/.ssh/pixeon-bastion-${var.env}.pem")}"
    }

  }

}

resource "aws_instance" "this_t2" {
  count = "${var.instance_count * local.is_t_instance_type}"

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  iam_instance_profile   = "${var.iam_instance_profile}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  #assign_eip_address          = "${var.assign_eip_address}"
  private_ip                  = "${var.private_ip}"
  ipv6_address_count          = "${var.ipv6_address_count}"
  ipv6_addresses              = "${var.ipv6_addresses}"

  ebs_optimized          = "${var.ebs_optimized}"
  volume_tags            = "${var.volume_tags}"
  root_block_device      = "${var.root_block_device}"
  ebs_block_device       = "${var.ebs_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"

  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  placement_group                      = "${var.placement_group}"
  tenancy                              = "${var.tenancy}"

  credit_specification {
    cpu_credits = "${var.cpu_credits}"
  }

  tags = "${merge(var.tags, map("Name", var.instance_count > 1 ? format("%s-%d", var.name, count.index+1) : var.name))}"

  lifecycle {
    # Due to several known issues in Terraform AWS provider related to arguments of aws_instance:
    # (eg, https://github.com/terraform-providers/terraform-provider-aws/issues/2036)
    # we have to ignore changes in the following arguments
    ignore_changes = ["private_ip", "root_block_device", "ebs_block_device", "subnet_id"]
  }

  ###########
  ## Custom #
  ###########
  provisioner "chef" {
    environment     = "${var.chef_environment}"
    run_list        = ["${var.chef_run_list}"]
    node_name       = "${upper(var.name)}"
    server_url      = "${var.chef_server_url}"
    user_name       = "sre"
    recreate_client = "${var.chef_recreate_client}"
    user_key        = "${file("../../../../../chef/sre.pem")}"
    #user_key        = "${file("${var.chef_user_key}")}" #"${file("../../../../../chef/sre.pem")}"
    #secret_key      = "${file("~/.chef/encrypted_data_bag_secret")}"
    #version         = "${var.chef_version}"
    
    on_failure      = "continue"

    attributes_json = "${var.chef_attributes_json}"

    connection {
      type                = "${var.chef_connection_type}"
      user                = "${var.chef_connection_user}"
        host                = "${aws_instance.this_t2.private_ip}"
      password            =  "${var.chef_connection_password}"
      private_key         = "${file("~/.ssh/pixeon-cloud-prod.pem")}"
      #private_key         = "${file("~/.ssh/pixeon-cloud-${var.stack_env}.pem")}"
      # bastion_user        = "centos"
      # bastion_host        = "${data.aws_instance.bastion.private_ip}"
      # bastion_private_key = "${file("~/.ssh/pixeon-bastion-${var.env}.pem")}"
    }

  }
}


resource "null_resource" "rerun" {
    count  = "${var.chef_rerun == true ? 1 : 0}"
    triggers {
      rerun = "${uuid()}"
    }
    connection {
      host                = "${element(aws_instance.this_t2.*.private_ip, 0)}"
    type                = "${var.chef_connection_type}"
    user                = "${var.chef_connection_user}"
    password            =  "${var.chef_connection_password}"
    }
    provisioner "remote-exec" {
      inline = [
        "chef-client -o 'recipe[korus_app::configure],recipe[korus_app::configure_winservices]'"
      ]
    }
 }





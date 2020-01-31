/*
AWS Instance Pixeon Server
*/

resource "aws_instance" "pixeon_server" {
  ami           = "${var.amazon_machine_image}"
  instance_type = "${var.server_instance_type}"
  
  vpc_security_group_ids = ["${aws_security_group.publicsg.id}"]
  #subnet_id              = "data.aws_subnet_ids.public.id"
  subnet_id              = "subnet-0c8630610ef40418b"
  key_name               = "pixeon-cloud-${var.stack_env}"

  root_block_device {
    delete_on_termination = true
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
  }

  tags {
    Name = "${upper(var.server_name)}"
    Creation-Tool = "terraform"
    Env = "${var.stack_env}"
    Squad = "${var.squad}"
  }

  ###########
  ## Custom #
  ###########
  provisioner "chef" {
    environment     = "${var.chef_environment}"
    run_list        = ["${var.chef_run_list}"]
    node_name       = "${upper(var.name)}"
    server_url      = "${var.chef_server_url}"
    user_name       = "${var.chef_user_name}"
    recreate_client = "${var.chef_recreate_client}"
    user_key        = "${file("${path.module}/adonis_almeida.pem")}" #"${var.chef_user_key}"
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

###########
## Custom #
###########
# resource "null_resource" "rerun" {
#     triggers {
#       rerun = "${uuid()}"
#     }
#     connection {
#       host                = "${element(aws_instance.this_t2.*.private_ip, 0)}"
#       type                = "${var.chef_connection_type}"
#       user                = "${var.chef_connection_type}"
#       password            =  "${var.chef_connection_type}"
#     }
#     provisioner "remote-exec" {
#       inline = [
#         "chef-client -o role[korus_app_front]"
#       ]
#     }
# }

output "ip" {
  value = "${aws_instance.pixeon_server.public_ip}"
}


/* resource "aws_eip" "winservices" {
  vpc      = true
  instance = "${aws_instance.winservices.id[0]}"

  tags {
    Name = "${upper(var.name)}"
    Creation-Tool = "terraform"
    Env = "${var.stack_env}"
    Squad = "${var.squad}"
  }
} */

resource "aws_route53_record" "korus_winservices_record" {    
    zone_id = "${data.aws_route53_zone.selected.zone_id}"
    name    = "winservices.${var.name_all}.${var.domain_zone}"
    type    = "A"
    ttl     = "300"
    records = ["${module.korus_winservices.private_ip}"]
    provider = "aws.pixeon-aws"
    lifecycle {
        create_before_destroy = true
    }
}

module "korus_winservices" {
  source                  = "../terraform-aws-ec2-instance"
  # source                  = "terraform-aws-modules/ec2-instance/aws"
  # version                 = "1.12.0"

  name                    = "${upper(var.name)}"
  #instance_count          = 1

  ami                     = "${var.ami}"
  instance_type           = "${var.server_instance_type}"
  key_name                = "pixeon-cloud-${var.stack_env}"
  monitoring              = true
  vpc_security_group_ids  = ["${aws_security_group.instance.id}"]
  subnet_id               = "${var.subnet_id}"
  
  associate_public_ip_address = true
  assign_eip_address = "${var.assign_eip_address}"

  root_block_device = [{
    delete_on_termination = true
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
  }]

  tags {
    Name = "${upper(var.name)}"
    Creation-Tool = "terraform"
    Env = "${var.stack_env}"
    Squad = "${var.squad}"
  }

  ## Chef
  chef_environment     = "${var.chef_environment}"
  chef_run_list        = ["${var.chef_run_list}"]
  chef_node_name       = "${upper(var.name)}"
  chef_server_url      = "${var.chef_server_url}"
  chef_user_name       = "${var.chef_user_name}"
  chef_recreate_client = "${var.chef_recreate_client}"
  chef_user_key        = ""
  chef_attributes_json = "${var.chef_attributes_json}"
  chef_connection_type = "${var.chef_connection_type}"
  chef_connection_user = "${var.chef_connection_user}"
  chef_connection_password = "${var.chef_connection_password}"
  chef_rerun="${var.chef_rerun}"
}


# resource "aws_volume_attachment" "this_ec2" {
#   device_name = "/dev/sdc"
#   volume_id   = "${aws_ebs_volume.this.id}"
#   instance_id = "${module.korus_winservices.id[0]}"
# }

# resource "aws_ebs_volume" "this" {
#   availability_zone = "${module.korus_winservices.availability_zone[0]}"
#   size              = "${var.volume_size}"
# }







/* resource "aws_instance" "winservices" {
  ami           = "${var.amazon_machine_image}"
  instance_type = "${var.server_instance_type}"
  
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  subnet_id              = "${data.aws_subnet_ids.public.id}"
  key_name               = "pixeon-cloud-${var.stack_env}"

  root_block_device {
    delete_on_termination = true
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
  }

  tags {
    Name = "${upper(var.name)}"
    Creation-Tool = "terraform"
    Env = "${var.stack_env}"
    Squad = "${var.squad}"
  }
} */
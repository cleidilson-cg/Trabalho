
module "korus_cluster" {
  source                  = "../terraform-aws-ec2-instance"
  # source                  = "terraform-aws-modules/ec2-instance/aws"
  # version                 = "1.12.0"

  name                    = "${upper(var.name)}"
  instance_count          = "${var.instance_count}"

  ami                     = "${var.ami}"
  instance_type           = "${var.server_instance_type}"
  key_name                = "pixeon-cloud-${var.stack_env}"
  monitoring              = true
  vpc_security_group_ids  = ["${aws_security_group.instance.id}"]
  subnet_id               = "${var.subnet_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
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

 resource "aws_route53_record" "korus_web_record" {    
    zone_id = "${data.aws_route53_zone.selected.zone_id}"
    name    = "${var.server_dns}.${var.name_all}.${var.domain_zone}"
    type    = "A"
    ttl     = "300"
    records = ["${module.korus_cluster.private_ip}"]
    provider = "aws.pixeon-aws"
    lifecycle {
        create_before_destroy = true
    }
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


# CREATE THE AUTO SCALING GROUP
/* resource "aws_autoscaling_group" "web" {
  launch_configuration = "${aws_launch_configuration.web.id}"
  vpc_zone_identifier = ["${data.aws_subnet_ids.private.ids}"]

  min_size = "${var.scaling_min_size}"
  max_size = "${var.scaling_max_size}"

  #load_balancers = ["${aws_elb.web.name}"]
  load_balancers = ["${var.lb_name}"]
  health_check_type = "ELB"

  tags = [
    {
      key = "Name"
      value = "${upper(var.server_name)}"
      propagate_at_launch = true
    },
    {
      key = "Creation-Tool"
      value = "terraform"
      propagate_at_launch = true
    },
    {
      key = "Env"
      value = "${var.stack_env}"
      propagate_at_launch = true
    },
    {
      key = "Squad"
      value = "${var.squad}"
      propagate_at_launch = true
    },
  ]
  
} */

# CREATE A LAUNCH CONFIGURATION THAT DEFINES EACH EC2 INSTANCE IN THE ASG
/* resource "aws_launch_configuration" "web" {
  name_prefix       = "${upper(var.server_name)}"
  image_id          = "${var.amazon_machine_image}"
  instance_type     = "${var.server_instance_type}"
  security_groups   = ["${aws_security_group.instance.id}"]
  #vpc_security_group_ids = ["${aws_security_group.publicsg.id}"]
  #subnet_id              = "data.aws_subnet_ids.public.id"
  #subnet_id              = "subnet-0c8630610ef40418b"
  key_name               = "pixeon-cloud-${var.stack_env}"

  root_block_device {
    delete_on_termination = true
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
  }

  #user_data = <<-EOF
  #            #!/bin/bash
  #            echo "Hello, World" > index.html
  #            nohup busybox httpd -f -p "${var.server_port}" &
  #            EOF

  lifecycle {
    create_before_destroy = true
  }
 
}
 */
# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN ELB TO ROUTE TRAFFIC ACROSS THE AUTO SCALING GROUP
# ---------------------------------------------------------------------------------------------------------------------
/* resource "aws_elb" "web" {
  #name = "terraform-asg-web"
  name            = "${upper(var.server_name)}-asg"
  security_groups = ["${aws_security_group.elb.id}"]
  #availability_zones = ["${data.aws_availability_zones.all.names}"]
  #subnets = ["subnet-0010f0add61d1dc3b", "subnet-07a3a84526d7f5ea1"]
  subnets         = ["${data.aws_subnet_ids.private.ids}"]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.server_port}/"
  }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }
} */

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP THAT CONTROLS WHAT TRAFFIC AN GO IN AND OUT OF THE ELB
# ---------------------------------------------------------------------------------------------------------------------
/* resource "aws_security_group" "elb" {
  #name = "terraform-web-elb"
  name = "${upper(var.server_name)}-elb"
  vpc_id = "${data.aws_vpc.environment.id}"

  # Allow all outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTP from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
} */
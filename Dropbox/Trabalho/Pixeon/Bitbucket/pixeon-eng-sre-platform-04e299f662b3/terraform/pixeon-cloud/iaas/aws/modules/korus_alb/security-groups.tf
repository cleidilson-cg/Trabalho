/*
  Security Group Korus ALB
*/
resource "aws_security_group" "pixeon_korus_alb_sg" {
  name = "${upper(var.name)}"
  vpc_id = "${data.aws_vpc.environment.id}"
  # vpc_id = "${module.pixeon_data.aws_vpc_environment_id}"

  # Inbound HTTP from anywhere
  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # aws_launch_configuration.launch_configuration in this module sets create_before_destroy to true, which means
  # everything it depends on, including this resource, must set it as well, or you'll get cyclic dependency errors
  # when you try to do a terraform destroy.
  lifecycle {
    create_before_destroy = true
  }

  tags {
    name            = "${upper(var.name)}"
    Creation-Tool   = "terraform"
    Env             = "${var.stack_env}"
    Squad           = "${var.squad}"
  }
}
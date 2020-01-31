# CREATE THE SECURITY GROUP THAT'S APPLIED TO EACH EC2 INSTANCE IN THE ASG
resource "aws_security_group" "instance" {
  name = "${upper(local.name_all)}-instance"
  vpc_id = "${data.aws_vpc.environment.id}"

  # SSH
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    description="RDP All"
    cidr_blocks = ["10.224.0.0/18","172.30.0.0/16"]
  }

  ingress {
    from_port = "1194"
    to_port = "1194"
    protocol = "udp"
    description="openvpn udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    name            = "${upper(local.name_all)}"
    Creation-Tool = "terraform"
    Env = "${local.stack_env}"
    Billing = "${local.billing}"
    Squad = "${local.squad}"
    App = "${local.app_name}"
  }
}
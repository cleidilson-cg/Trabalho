# CREATE THE SECURITY GROUP THAT'S APPLIED TO EACH EC2 INSTANCE IN THE ASG
resource "aws_security_group" "instance" {
  name = "${upper(local.name_all)}-instance"
  vpc_id = "${data.aws_vpc.environment.id}"

  # WinRM
  ingress {
    from_port = "5985"
    to_port = "5985"
    protocol = "tcp"
    description="WinRM All"
    cidr_blocks = ["10.224.0.0/18","172.30.0.0/16"]
  }

  # RDP
  ingress {
    from_port = "3389"
    to_port = "3389"
    protocol = "tcp"
    description="RDP All"
    cidr_blocks = ["10.224.0.0/18","172.30.0.0/16"]
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
    Creation-Tool   = "terraform"
    Env             = "${local.stack_env}"
    Squad           = "${local.squad}"
  }
}
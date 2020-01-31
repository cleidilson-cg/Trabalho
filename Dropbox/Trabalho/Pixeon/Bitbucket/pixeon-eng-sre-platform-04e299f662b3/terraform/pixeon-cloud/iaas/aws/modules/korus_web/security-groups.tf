# CREATE THE SECURITY GROUP THAT'S APPLIED TO EACH EC2 INSTANCE IN THE ASG
resource "aws_security_group" "instance" {
  name = "${upper(var.name)}-instance"
  vpc_id = "${data.aws_vpc.environment.id}"

  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    description="Korus ${var.name}"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # WinRM
  ingress {
    from_port = "5985"
    to_port = "5985"
    protocol = "tcp"
    description="WinRM All"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # RDP
  ingress {
    from_port = "3389"
    to_port = "3389"
    protocol = "tcp"
    description="RDP All"
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
    name            = "${upper(var.name)}"
    Creation-Tool   = "terraform"
    Env             = "${var.stack_env}"
    Squad           = "${var.squad}"
  }
}
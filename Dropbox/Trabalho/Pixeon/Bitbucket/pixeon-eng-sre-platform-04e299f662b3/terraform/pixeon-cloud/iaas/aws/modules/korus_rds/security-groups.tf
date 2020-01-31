resource "aws_security_group" "korus_db_security_group" {
  name = "${upper(var.name)}-instance-db"
  description = "RDS Korus servers (terraform-managed)"
  vpc_id = "${data.aws_vpc.environment.id}"

  # Only postgres in
  ingress {
    from_port = "${var.port}"
    to_port = "${var.port}"
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
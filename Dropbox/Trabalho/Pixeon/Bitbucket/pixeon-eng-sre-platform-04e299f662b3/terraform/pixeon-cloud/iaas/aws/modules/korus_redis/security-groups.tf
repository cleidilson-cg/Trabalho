/*
  Security Group Korus Redis
*/
resource "aws_security_group" "pixeon_korus_redis_sg" {
  name = "${upper(var.name)}"
  description = "${var.description} Security Group (terraform-managed)"
  vpc_id = "${data.aws_vpc.environment.id}"

  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = "${split(",", "${var.ingress_cidr_blocks}")}"
    description=""
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${data.aws_vpc.environment.id}"

  tags {
    name            = "${upper(var.name)}"
    Creation-Tool   = "terraform"
    Env             = "${var.stack_env}"
    Squad           = "${var.squad}"
  }
}


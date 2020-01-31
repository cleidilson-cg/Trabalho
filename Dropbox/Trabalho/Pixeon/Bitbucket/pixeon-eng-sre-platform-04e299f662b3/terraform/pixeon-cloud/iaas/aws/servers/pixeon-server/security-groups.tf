/*
  Security Group Pixeon Server
*/

/* Public Access SG  */

resource "aws_security_group" "publicsg" {
  name        = "${upper(var.server_name)}"
  description = "Allow traffic to pass from the internet to the public subnet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${data.aws_vpc.environment.id}"

  tags {
    name          = "${upper(var.server_name)}"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
    Squad         = "${var.squad}"
  }
}

/*
  Security Group RDS Postgresql Pixeon 
*/

/* Public Access SG  */

resource "aws_security_group" "pixeon_db_security_group" {
  name = "tstpixjirards01"

  description = "RDS JiraDB postgres servers (terraform-managed)"

  # Only postgres in
  ingress {
    from_port = 5432
    to_port = 5432
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

  vpc_id = "${data.aws_vpc.environment.id}"

  tags {
    name            = "tstpixjirards01"
    Creation-Tool   = "terraform"
    Env             = "${var.stack_env}"
    Squad           = "${var.squad}"
  }
}


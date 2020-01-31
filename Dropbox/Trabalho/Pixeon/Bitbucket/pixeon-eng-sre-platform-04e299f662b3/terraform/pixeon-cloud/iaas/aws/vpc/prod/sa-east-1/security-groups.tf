/*
  Security Group NAT
*/

resource "aws_security_group" "sgnat" {
  name        = "${var.stack_name}-${var.stack_env}-private-sg"
  description = "Allow traffic to pass from the private subnet to the internet"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.pixeon_cloud_azure_network}"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.orch_prod_network}"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.pixeon_scs_network}"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.pixeon_ssa_network}"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.pixeon_fln_network}"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.pixeon_old_network}"]
  }
  

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  tags {
    Name          = "${var.stack_name}-${var.stack_env}-private-sg"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}


/* Public Access SG  */

resource "aws_security_group" "publicsg" {
  name        = "${var.stack_name}-${var.stack_env}-public-sg"
  description = "Allow traffic to pass from the internet to the public subnet"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

// IPSec VPN

  ingress {
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  tags {
    Name          = "${var.stack_name}-${var.stack_env}-public-sg"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}



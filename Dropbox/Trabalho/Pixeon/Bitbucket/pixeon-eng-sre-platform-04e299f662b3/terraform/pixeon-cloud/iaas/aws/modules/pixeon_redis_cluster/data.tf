// VPC
data "aws_vpc" "environment" {
  tags {
    Name = "${var.vpc_name}"
  }
}


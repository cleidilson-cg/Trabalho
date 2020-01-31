data "aws_vpc" "environment" {
  tags {
    Name = "pixeon-cloud-${var.stack_vpc}-vpc"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.environment.id}"

  tags {
    Env = "${var.stack_env}"
    Tier        = "public"
  }
}

data "aws_subnet" "public" {
  count = "${length(data.aws_subnet_ids.public.ids)}"
  id    = "${data.aws_subnet_ids.public.ids[count.index]}"
}

data "aws_subnet_ids" "private" {
  vpc_id    = "${data.aws_vpc.environment.id}"

  tags {
    Env     = "${var.stack_env}"
    Tier    = "private"
  }
}

data "aws_subnet" "private" {
  count = "${length(data.aws_subnet_ids.private.ids)}"
  id    = "${data.aws_subnet_ids.private.ids[count.index]}"
}

data "aws_route53_zone" "selected" {
    name         = "${var.domain_zone}."#"pixeon.cloud."
    private_zone = false
    provider = "aws.pixeon-aws"
}
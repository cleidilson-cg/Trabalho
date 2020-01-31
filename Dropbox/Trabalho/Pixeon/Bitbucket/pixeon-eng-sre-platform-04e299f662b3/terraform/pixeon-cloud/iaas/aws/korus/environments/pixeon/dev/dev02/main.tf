terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${local.aws_region}"
  profile = "${local.aws_profile}"
  version = "~> 1.46"
}

locals {
  # Global
  aws_region = "us-east-1"
  aws_profile = "pixeon"

  stack_name="korus_dev02"
  stack_env="dev"
  squad="Pixeon"

  name_all="devpixkorus002"

  # Front
  amazon_machine_image_front="ami-02b411190e42cf724"

  # Back
  amazon_machine_image_back="ami-02b411190e42cf724"
}




terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "~> 1.46"
}

module "korus_global_variables" {
  source = "../../korus_global_variables"

}

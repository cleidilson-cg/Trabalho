terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${local.aws_region}"
  profile = "${local.aws_profile}"
  version = "~> 1.46"
}

module "korus_global_variables" {
  source = "../../../modules/korus_global_variables"

}
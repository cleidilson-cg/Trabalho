/* General Parameters */
terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "~> 1.46"
}

provider "aws" {
  alias   =  "aws-pixeon"
  region  = "${var.aws_region}"
  profile = "pixeon"
  version = "~> 1.46"
}

variable "aws_region" {
  description = "The region of AWS"
  type = "string"
}

variable "aws_profile" {
  description = "The profile used with AWS Credentials"
  type = "string"
}

variable "stack_name" {
  description = "Name of environment implanted"
  type = "string"
}

variable "stack_env" {
  description = "Type of environment implanted"
  type = "string"
}

variable "domain_zone" {
  description = "Name of dns domain to be used"
  type = "string"
}
variable "domain_names" {
  description = "Name of dns domain to be used"
  type = "list"
    default = [
    "jambo.pleres.net",
    "amarelo.pleres.net"
  ]
}

variable "squad" {
  description = "Team responsible for the environment"
  type = "string"
}

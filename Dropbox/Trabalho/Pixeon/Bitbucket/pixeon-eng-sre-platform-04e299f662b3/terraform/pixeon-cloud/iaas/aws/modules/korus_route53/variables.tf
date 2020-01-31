/* General Parameters */
terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
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

variable "squad" {
  description = "Team responsible for the environment"
  type = "string"
}
variable "domain_zone" 
{
    type = "string"
}
variable "route53_count_records_dns" {}

variable "route53_records_dns" {
  description = "An array of 'route53_records_dns' to setup for the Dns"
  type        = "list"
}

variable "route53_type" { 
  default="CNAME"
  type = "string"
}
variable "name_all"
{
    type = "string"
}
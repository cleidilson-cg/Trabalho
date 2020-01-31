provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "~> 1.46"
}

variable "name" {
  description = "A descriptive name for this NLB"
}

variable "aws_region" {
  description = "The region of AWS"
}

variable "aws_profile" {
  description = "The profile used with AWS Credentials"
}

variable "environment" {
  description = "An envionment name for the NLB"
}

variable "dns_zone" {
  description = "The AWS route53 domain name hosting the dns entry"
}

variable "dns_nlb" {
  description = "Friendly dns to NLB"
  default     = ""
}

variable "dns_alias_nlb" {
  description = "Aliases to friendly dns"
  type        = "list"
}

variable "dns_type" {
  description = "The dns record type to use when adding the dns entry"
  default     = "A"
}

variable "dns_name" {
  description = "An optional hostname to add to the hosting zone, otherwise defaults to var.name"
  default     = ""
}

variable "subnet_tags" {
  description = "A map of tags used to filter the subnets you want the NLB attached"
  type        = "map"
  default     = {}
}

variable "ec2_tags" {
  description = "A map of tags used to filter the instances you want the Target Group attached"
  type        = "map"
  default     = {}
}

variable "listeners" {
  description = "An array of listeners to setup for the NLB"
  type        = "list"
}

variable "tags" {
  description = "A map of tags which will be added to the NLB cloud tags"
  type        = "map"
  default     = {}
}

variable "internal" {
  description = "Indicates if the NLB should be an internal load balancer, defaults to true"
  default     = true
}

variable "idle_timeout" {
  description = "The timeout applie to idle ELB connections"
  default     = "120"
}

variable "deregistration_delay" {
  description = "The amount time for Network Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  default     = "60"
}

variable "health_check_interval" {
  description = "The interval between performing a health check"
  default     = "30"
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = "3"
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  default     = "3"
}

variable "vpc_id" {
  description = "The VPC id you are building the network load balancer in"
}

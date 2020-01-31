/* General Parameters */

/* SSL Certificate Parameters */

variable "certificate_arn" {
  type    = "string"
  default = "arn:aws:acm:us-east-1:708426649097:certificate/4bb330c0-11d4-4995-ba9c-aa7abca64f0d"
}

/* DNS Zone */

data "aws_route53_zone" "pixeon_public_zone" {
  name         = "pixeon.cloud"
  private_zone = false
}

/* Database Parameters */

variable "db_user" {
  type    = "string"
  default = "root"
}

variable "db_pass" {
  type    = "string"
  default = "5689dc63530e6bea2e31265b7e90f0df"
}

/* Rancher Server */

variable "rancher_version" {
  type    = "string"
  default = "rancher/server:stable"
}

variable "rancher_db_name" {
  type    = "string"
  default = "rancher"
}

variable "rancher_db_user" {
  type    = "string"
  default = "rancheruser"
}

variable "rancher_db_pass" {
  type    = "string"
  default = "5689dc63530e6bea"
}

variable "ssh_key_name" {
  type    = "string"
  default = "pixeon-caas-production"
}

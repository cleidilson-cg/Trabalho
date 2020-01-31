/* General Parameters */

provider "aws" {
  region = "us-east-1"
}

variable "aws_region" {
  type    = "string"
  default = "us-east-1"
}

variable "stack_name" {
  type    = "string"
  default = "infra"
}

variable "stack_env" {
  type    = "string"
  default = "orchestration"
}

/* VPC Parameters */

variable "vpc_cidr" {
  type    = "string"
  default = "10.42.0.0/16"
}

variable "private_subnet_b_cidr" {
  type    = "string"
  default = "10.42.0.0/23"
}

variable "private_subnet_c_cidr" {
  type    = "string"
  default = "10.42.2.0/23"
}

variable "public_subnet_b_cidr" {
  type    = "string"
  default = "10.42.4.0/23"
}

variable "public_subnet_c_cidr" {
  type    = "string"
  default = "10.42.6.0/23"
}

/* VPC Peering Connections */

/* Production */

variable "integration_peer_owner_id" {
  type    = "string"
  default = ""
}

variable "integration_peer_vpc_id" {
  type    = "string"
  default = ""
}

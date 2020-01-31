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
  default = "caas2"
}

variable "stack_env" {
  type    = "string"
  default = "staging"
}

/* VPC Parameters */

variable "vpc_cidr" {
  type    = "string"
  default = "10.224.0.0/18"
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

// Production

variable "pixeon_prod_peer_owner_id" {
  type    = "string"
  default = ""
}

variable "pixeon_prod_peer_id" {
  type    = "string"
  default = "pcx-02d889ba33cba6b4f"
}

variable "pixeon_prod_network" {
  type = "string"
  default = "172.30.0.0/16"
}


variable "pixeon_prod_peer_vpc_id" {
  type    = "string"
  default = ""
}

// Alliar

variable "alliar_prod_peer_owner_id" {
  type    = "string"
  default = ""
}


variable "alliar_prod_peer_id" {
  type    = "string"
  default = "pcx-0b24d0652d7290262"
}

variable "alliar_prod_peer_vpc_id" {
  type    = "string"
  default = ""
}

variable "alliar_prod_network" {
  type = "string"
  default = "172.31.0.0/16"
}
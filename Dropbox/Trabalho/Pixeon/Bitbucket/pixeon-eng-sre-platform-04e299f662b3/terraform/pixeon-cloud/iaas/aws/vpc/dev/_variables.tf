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
  default = "pixeon-cloud"
}

variable "stack_env" {
  type    = "string"
  default = "dev"
}

/* VPC Parameters */

variable "vpc_cidr" {
  type    = "string"
  default = "10.224.200.0/21"
}

variable "private_subnet_a_cidr" {
  type    = "string"
  default = "10.224.200.0/23"
}

variable "private_subnet_c_cidr" {
  type    = "string"
  default = "10.224.202.0/23"
}

variable "public_subnet_a_cidr" {
  type    = "string"
  default = "10.224.204.0/23"
}

variable "public_subnet_c_cidr" {
  type    = "string"
  default = "10.224.206.0/23"
}

variable "firewall_local_interface" {
  type    = "string"
  default = "eni-0cc9898cd20ed4699"
}
variable "pixeon_cloud_azure_network" {
  type    = "string"
  default = "10.227.0.0/16"
}

/* VPC Peering Connections */

// Production

variable "pixeon_old_peer_owner_id" {
  type    = "string"
  default = ""
}


variable "pixeon_cloud_prod_peer_id" {
  type    = "string"
  default = "pcx-0572b31626b5a7deb"
}

variable "pixeon_cloud_prod_network" {
  type = "string"
  default = "10.224.0.0/18"
}


variable "pixeon_old_peer_vpc_id" {
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
  default = "pcx-0dd5a80787f1b05d1"
}

variable "alliar_prod_peer_vpc_id" {
  type    = "string"
  default = ""
}

variable "alliar_prod_network" {
  type = "string"
  default = "172.31.0.0/16"
}



// Orchestration VPC

variable "orch_prod_peer_owner_id" {
  type    = "string"
  default = ""
}


variable "orch_prod_peer_id" {
  type    = "string"
  default = "pcx-07c20942f14c46a42"
}

variable "orch_prod_peer_vpc_id" {
  type    = "string"
  default = ""
}

variable "orch_prod_network" {
  type = "string"
  default = "10.42.0.0/16"
}



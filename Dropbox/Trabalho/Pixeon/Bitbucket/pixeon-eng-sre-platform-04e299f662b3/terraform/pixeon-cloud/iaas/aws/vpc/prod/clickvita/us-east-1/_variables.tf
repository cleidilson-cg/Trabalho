/* General Parameters */

provider "aws" {
  region = "us-east-1"
  profile = "clickvita"
}

variable "aws_region" {
  type    = "string"
  default = "us-east-1"
}

variable "stack_name" {
  type    = "string"
  default = "clickvita"
}

variable "stack_env" {
  type    = "string"
  default = "prod"
}

/* VPC Parameters */

variable "vpc_cidr" {
  type    = "string"
  default = "10.225.64.0/18"
}

variable "private_subnet_a_cidr" {
  type    = "string"
  default = "10.225.64.0/22"
}


variable "private_subnet_b_cidr" {
  type    = "string"
  default = "10.225.68.0/22"
}


variable "private_subnet_c_cidr" {
  type    = "string"
  default = "10.225.72.0/22"
}

variable "public_subnet_a_cidr" {
  type    = "string"
  default = "10.225.76.0/22"
}

variable "public_subnet_b_cidr" {
  type    = "string"
  default = "10.225.80.0/22"
}


variable "public_subnet_c_cidr" {
  type    = "string"
  default = "10.225.84.0/22"
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

// Pixeon Cloud Dev and Test Peering 

variable "pixeon_cloud_dev_peer_id" {
  type    = "string"
  default = "pcx-0572b31626b5a7deb"
}

variable "pixeon_cloud_dev_network" {
  type = "string"
  default = "10.224.200.0/21"
}

variable "pixeon_cloud_test_peer_id" {
  type    = "string"
  default = "pcx-08226dc5d2223d1a2"
}

variable "pixeon_cloud_test_network" {
  type = "string"
  default = "10.224.192.0/21"
}


// Production

variable "pixeon_old_peer_owner_id" {
  type    = "string"
  default = ""
}

variable "pixeon_old_peer_id" {
  type    = "string"
  default = "pcx-03157e6223fd525d3"
}

variable "pixeon_old_network" {
  type = "string"
  default = "172.30.0.0/16"
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

// Pixeon Branchs Networks

variable "pixeon_scs_network" {
  type = "string"
  default = "10.11.0.0/16"
}

variable "pixeon_ssa_network" {
  type = "string"
  default = "10.71.0.0/16"
}

variable "pixeon_fln_network" {
  type = "string"
  default = "10.48.0.0/16"
}

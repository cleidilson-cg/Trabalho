/* General Parameters */

provider "azure" {
  region = "eastus"
}

variable "stack_location" {
  type    = "string"
  default = "East US"
}

variable "stack_name" {
  type    = "string"
  default = "pixeon-cloud"
}

variable "stack_env" {
  type    = "string"
  default = "dev"
}

/* Virtual Network Parameters */

variable "virtual_network_cidr" {
  type    = "string"
  default = "10.227.200.0/21"
}

variable "private_subnet_cidr" {
  type    = "string"
  default = "10.227.204.0/22"
}

variable "public_subnet_cidr" {
  type    = "string"
  default = "10.227.200.0/22"
}

variable "pixeon_cloud_aws_network" {
  type    = "string"
  default = "10.224.0.0/16"
}
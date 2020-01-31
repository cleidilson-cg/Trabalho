/* General Parameters */

provider "azure" {
  region = "brazilsouth"
}

variable "stack_location" {
  type    = "string"
  default = "Brazil South"
}

variable "stack_name" {
  type    = "string"
  default = "pixeon-cloud"
}

variable "stack_env" {
  type    = "string"
  default = "prod"
}

/* Virtual Network Parameters */

variable "virtual_network_cidr" {
  type    = "string"
  default = "10.227.0.0/18"
}

variable "private_subnet_cidr" {
  type    = "string"
  default = "10.227.16.0/20"
}

variable "public_subnet_cidr" {
  type    = "string"
  default = "10.227.0.0/20"
}

variable "firewall_local_ip" {
  type    = "string"
  default = "10.227.0.0/20"
}
variable "pixeon_cloud_aws_network" {
  type    = "string"
  default = "10.224.0.0/16"
}
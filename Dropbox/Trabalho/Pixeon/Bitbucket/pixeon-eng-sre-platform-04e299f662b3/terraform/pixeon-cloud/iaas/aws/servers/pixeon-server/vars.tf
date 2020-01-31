/* General Parameters */
provider "aws" {
  region = "${var.aws_region}"
}

variable "aws_region" {}

variable "amazon_machine_image" {}

variable "stack_name" {}

variable "stack_env" {}

variable "server_name" {}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {}

variable "server_instance_type" {}

variable "squad" {}

variable "rds_volume_size" {}


provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "~> 1.46"
}

variable "name" {
  description = "A descriptive name for this Korus Web"
}

variable "name_all" {
  description = "A descriptive name for this Korus Web"
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

variable "ami" {
  description = "ID of AMI to use for the instance"
  type = "string"
}

variable "volume_type" {
  description = "The type of volume. Can be 'standard', 'gp2', 'io1', 'sc1', or 'st1'. (Default: 'gp2')."
  type = "string"
  default = "gp2"
}

variable "volume_size" {
  description = "The size of the volume in gigabytes"
  type = "string"
  default = "50"
}

variable "server_instance_type" {
  description = "The type of instance to start"
  type = "string"
}

variable "korus_from_port" {
  type = "string"
}

variable "korus_to_port" {
  type = "string"
}

variable "associate_public_ip_address"
{
    type = "string"
}
variable "assign_eip_address" {
  description = "Assign EIP to instance"
}

## Chef
variable "chef_environment" { }
variable "chef_run_list" { 
  description = "The chef runlist to be executed"
  default     = []
}
variable "chef_node_name" {
  description = ""
  type        = "string"
}
variable "chef_server_url" {
  description = ""
  type        = "string"
}
variable "chef_user_name" {
  description = ""
  type        = "string"
}
variable "chef_recreate_client" {
  description = ""
  type        = "string"
}
variable "chef_user_key" {
  description = ""
  type        = "string"
}
variable "chef_attributes_json" {
  description = ""
  type        = "string"
}

variable "chef_connection_type" {
  description = ""
  type        = "string"
}
variable "chef_connection_user" {
  description = ""
  type        = "string"
}
variable "chef_connection_password" {
  description = ""
  type        = "string"
}
variable "chef_rerun" {
  description = ""
}

variable "subnet_id" {
  description = "Subnet for winservices instance"
  type = "string"
}


variable "domain_zone" {
  description = "Domain zone for winservices instance"
  type = "string"
}



variable "stack_vpc" {
  description = "The vpc tag to be used used"
}
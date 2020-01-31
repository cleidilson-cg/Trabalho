/* General Parameters */
terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "~> 1.46"
}

variable "name" {
  description = "A descriptive name for this Korus"
  type = "string"
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

variable "description" {
  description = "The description of the Cluster Redis"
  type = "string"
}

variable "automatic_failover_enabled" {
  description = "A flag whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails."
  type = "string"
}

variable "availability_zones" {
  description = <<-HEREDOC
  "The Availability Zones data source allows access to the list of AWS Availability 
    Zones which can be accessed by an AWS account within the region configured in the provider."
  HEREDOC
  type = "string"
}

variable "node_type" {
  description = "The cluster node type."
  type = "string"
}

variable "number_cache_clusters" {
  description = "The number of cache clusters that the replication group has."
  type = "string"
}

variable engine_version {
  description = "Redis with a version of ElastiCache"
  type = "string"
}

variable "parameter_group_name" {
  description = "Name of the parameter group to associate with this cache cluster"
  type = "string"
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type = "string"
}


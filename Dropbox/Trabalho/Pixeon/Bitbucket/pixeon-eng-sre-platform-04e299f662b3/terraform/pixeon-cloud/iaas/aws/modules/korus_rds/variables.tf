terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "~> 1.46"
}

variable "name" {
  description = "A descriptive name for this Korus Web"
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

variable "engine" {
  description = "The database engine to use"
  type = "string"
}                   
variable "engine_version" {
  description = "The engine version to use"
  type = "string"
}                         
variable "instance_class" {
  description = "The instance type of the RDS instance"
  type = "string"
}
variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type = "string"
  default = "false"
}                                   
variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate. Setting this automatically disables parameter_group creation"
  type = "string"
}     
variable "username" {
  description = "Username for the master DB user"
  type = "string"
}                 
variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type = "string"
}                 
variable "port" {
  description = "The port on which the DB accepts connections"
  type = "string"
}                     
variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type = "string"
}      

variable "volume_size" {
  description = "The allocated storage in gigabytes"
  type = "string"
  default = "20"
}
variable "backup_retention_period" {
  description = "The days to retain backups for"
  type = "string"
  default = "1"
}

variable "volume_type" {
  description = <<-HEREDOC
  "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). 
    The default is 'io1' if iops is specified, 'standard' if not. 
    Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  HEREDOC
  type = "string"
  default = "gp2"
}
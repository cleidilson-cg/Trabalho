variable "aws_region"
{
    type = "string"
}
variable "aws_profile"
{
    type = "string"
}
variable "stack_name"
{
    type = "string"
}
variable "stack_env"
{
    type = "string"
}
variable "squad"
{
    type = "string"
}
variable "name_all"
{
    type = "string"
}
variable "domain_zone"
{
    type = "string"
}
variable "lb_name"
{
    type = "string"
}
variable "korus_from_port"
{
    type = "string"
}
variable "korus_to_port"
{
    type = "string"
}
variable "instance_type_front"
{
    type = "string"
}

variable "instance_type_winservices"
{
    type = "string"
}

variable "ami_front_A"
{
    type = "string"
}
variable "associate_public_ip_address"
{
    type = "string"
}
variable "assign_eip_address" {
  description = "Assign EIP to instance"
}
variable "rds_volume_size"
{
    type = "string"
}
variable "rds_backup_retention_period"
{
    type = "string"
}
variable "rds_engine"
{
    type = "string"
}
variable "rds_engine_version"
{
    type = "string"
}
variable "rds_instance_class"
{
    type = "string"
}
  
variable "rds_multi_az"
{
    type = "string"
}
variable "rds_parameter_group_name"
{
    type = "string"
}
variable "rds_username"
{
    type = "string"
}
variable "rds_password"
{
    type = "string"
}
variable "rds_port"
{
    type = "string"
}
variable "rds_publicly_accessible"
{
    type = "string"
}
variable "chef_environment"
{
    type = "string"
}
variable "chef_run_list"
{
    type = "list"
}
variable "chef_node_name"
{
    type = "string"
}
variable "chef_server_url"
{
    type = "string"
}
variable "chef_user_name"
{
    type = "string"
}
variable "chef_recreate_client"
{
    type = "string"
}
variable "chef_user_key"
{
    type = "string"
}
variable "chef_attributes_json_front_a"
{
    type = "string"
}
variable "chef_attributes_json_front_b"
{
    type = "string"
}
variable "chef_attributes_json_winservices"
{
    type = "string"
}

variable "chef_connection_type"
{
    type = "string"
}
variable "chef_connection_user"
{
    type = "string"
}
variable "chef_connection_password"
{
    type = "string"
}
variable "chef_rerun" {
  description = ""
}

variable "target_groups_frontend" {
  description = ""
  type        = "list"
}

variable "route53_records_dns" {
  description = ""
  type        = "list"
}

variable "environments" {
  description = "Name of dns domain to be used"
  type = "list"
}

variable "ami_winservices" {
  description = "Name of dns domain to be used"
  type = "string"
}


variable "stack_vpc" {
  description = "The vpc tag to be used used"
}
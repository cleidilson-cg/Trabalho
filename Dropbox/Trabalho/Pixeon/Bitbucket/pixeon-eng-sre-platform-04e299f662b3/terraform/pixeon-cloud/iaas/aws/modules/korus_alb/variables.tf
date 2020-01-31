provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "~> 1.46"
}

variable "name" {
  description = "A descriptive name for this LB"
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

variable "listeners" {
  description = "An array of listeners to setup for the LB"
  type        = "list"
}

variable "tags" {
  description = "A map of tags which will be added to the LB cloud tags"
  type        = "map"
  default = {}
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network. The default value is application"
  type = "string"
  default     = "application"
}

variable "internal" {
  description = "Indicates if the LB should be an internal load balancer, defaults to true"
  type = "string"
  default     = true
}

variable "idle_timeout" {
  description = "The timeout applie to idle ELB connections"
  type = "string"
  default     = "120"
}

variable "deregistration_delay" {
  description = "The amount time for Network Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  type = "string"
  default     = "60"
}

variable "health_check_interval" {
  description = "The interval between performing a health check"
  type = "string"
  default     = "30"
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type = "string"
  default     = "3"
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  type = "string"
  default     = "3"
}

variable "target_id_frontend_A" {
  description = "An array of 'frontend_A' to setup for the LB"
  type        = "list"
}
variable "target_id_frontend_B" {
  description = "An array of 'frontend_B' to setup for the LB"
  type        = "list"
}
variable "target_id_backend_A" {
  description = "An array of 'backend_A' to setup for the LB"
  type        = "list"
}
variable "target_id_backend_B" {
  description = "An array of 'backend_B' to setup for the LB"
  type        = "list"
}
variable "target_id_winservices" {
  description = "An array of 'winservices' to setup for the LB"
  type        = "list"
}

variable "target_groups_frontend" {
  description = "An array of 'target_groups_frontend' to setup for the LB"
  type        = "list"
}
variable "target_groups_backend" {
  description = "An array of 'target_groups_backend' to setup for the LB"
  type        = "list"
}
variable "target_groups_winservices" {
  description = "An array of 'target_groups_winservices' to setup for the LB"
  type        = "list"
}

variable "certificate_arn" {
  description = "The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS."
  type = "string"
}


variable "stack_vpc" {
  description = "The vpc tag to be used used"
}
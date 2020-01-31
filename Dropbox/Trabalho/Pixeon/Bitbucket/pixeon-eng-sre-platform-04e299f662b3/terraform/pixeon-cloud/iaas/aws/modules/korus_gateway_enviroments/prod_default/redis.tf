# /* Cluster Redis to System Korus */
module "korus_redis" {
  source = "../../korus_redis"

  aws_region = "${var.aws_region}"
  aws_profile = "${var.aws_profile}"
  name="${var.name_all}"
  description="Korus ${var.stack_env} Redis Cluster"
  automatic_failover_enabled=false
  availability_zones="us-east-1a"
  
  node_type="cache.t2.micro"
  number_cache_clusters="1"
  engine_version="5.0.0"
  parameter_group_name="default.redis5.0"
  ingress_cidr_blocks="172.30.0.0/16"
  
  stack_name="${var.stack_name}_redis"
  stack_env="${var.stack_env}"
  squad="${var.squad}"

}

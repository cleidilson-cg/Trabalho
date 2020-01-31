

# /* Cluster Redis to System Korus */
module "korus_redis_dev" {
  source = "../../../modules/korus_redis"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}"
  description="Korus ${local.stack_env} Redis Cluster"
  automatic_failover_enabled=false
  availability_zones="us-east-1a"
  
  node_type="cache.t2.micro"
  number_cache_clusters="1"
  engine_version="5.0.0"
  parameter_group_name="default.redis5.0"
  ingress_cidr_blocks="10.224.0.0/12,172.30.0.0/16"
  
  stack_name="${local.stack_name}_redis"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

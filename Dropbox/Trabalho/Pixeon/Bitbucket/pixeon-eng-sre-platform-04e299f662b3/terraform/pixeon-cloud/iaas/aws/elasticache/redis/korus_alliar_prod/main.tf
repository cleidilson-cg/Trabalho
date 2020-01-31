locals {
    name_all                     = "prdalliarredis02"
    aws_region                   = "sa-east-1"
    aws_profile                  = "alliar"
    domain_zone                  = "pleres.net"
    stack_name                   = "prdalliarredis02"
    stack_env                    = "prod"
    squad                        = "sre"
}

/* Criado em produçao em 21/12/2018 */
module "pixeon_redis" {
  source = "../../../modules/pixeon_redis_cluster"

  aws_region = "${local.aws_region}"
  aws_profile = "${local.aws_profile}"
  name="${local.name_all}"
  description="Korus Redis Cluster"
  vpc_name="VPC PROD"
  automatic_failover_enabled=true
  availability_zones="sa-east-1a,sa-east-1b"
  node_type="cache.t2.medium"
  number_cache_clusters="2"
  engine_version="5.0.0"
  parameter_group_name="default.redis5.0.cluster.on"
  ingress_cidr_blocks="172.31.0.0/16,172.30.0.0/16"
  
  stack_name="${local.stack_name}"
  stack_env="${local.stack_env}"
  squad="${local.squad}"

}

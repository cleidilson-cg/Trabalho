locals {
  
}

module "pixeon_redis" {
  source = "../../../modules/pixeon_redis"

  aws_region="sa-east-1"
  aws_profile="alliar"
  name="tstalliarredis01"
  description="Pixeon Teste Redis Cluster"
  vpc_name="VPC PROD"
  automatic_failover_enabled=false
  availability_zones="sa-east-1b"
  node_type="cache.t2.micro"
  number_cache_clusters="1"
  engine_version="5.0.0"
  parameter_group_name="default.redis5.0"
  ingress_cidr_blocks="172.31.0.0/16,172.30.0.0/16"
  
  stack_name="redis_korus"
  stack_env="test"
  squad="Pixeon"

}

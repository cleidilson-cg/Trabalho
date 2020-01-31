output "redis_configuration_endpoint_address" {
  value = "${aws_elasticache_replication_group.pixeon_pixeon_redis.configuration_endpoint_address}"
}
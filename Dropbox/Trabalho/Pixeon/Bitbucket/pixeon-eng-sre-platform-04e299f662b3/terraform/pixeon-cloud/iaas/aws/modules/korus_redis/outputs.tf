
output "redis_primary_endpoint_address" {
  value = "${aws_elasticache_replication_group.pixeon_korus_redis.primary_endpoint_address}"
}

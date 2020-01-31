resource "aws_elasticache_replication_group" "pixeon_pixeon_redis" {
  automatic_failover_enabled      = "${var.automatic_failover_enabled}"
  auto_minor_version_upgrade      = true
  replication_group_id            = "${var.name}"
  replication_group_description   = "${var.description} (terraform-managed)"
  availability_zones              = "${split(",", "${var.availability_zones}")}"
  engine                          = "redis"
  node_type                       = "${var.node_type}"
  number_cache_clusters           = "${var.number_cache_clusters}"
  port                            = "6379"
  parameter_group_name            = "${var.parameter_group_name}"
  engine_version                  = "${var.engine_version}"
  maintenance_window              = "sun:00:00-sun:01:00"
  security_group_ids              = ["${aws_security_group.pixeon_redis_sg.id}"]
  subnet_group_name               = "default"
  
  tags {
      Name            = "${var.name}"
      Creation-Tool   = "terraform"
      Env             = "${var.stack_env}"
      Squad           = "${var.squad}"
  }
}





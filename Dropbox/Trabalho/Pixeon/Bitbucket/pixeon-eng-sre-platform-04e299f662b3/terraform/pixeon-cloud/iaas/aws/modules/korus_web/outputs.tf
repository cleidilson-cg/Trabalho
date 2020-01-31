output "instances_id" {
  #value = "${join(",", module.korus_cluster.id)}"
  value = "${module.korus_cluster.id}"
} 
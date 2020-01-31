output "load_balancer_dns_name" {
  value = "${aws_lb.balancer.dns_name}"
}
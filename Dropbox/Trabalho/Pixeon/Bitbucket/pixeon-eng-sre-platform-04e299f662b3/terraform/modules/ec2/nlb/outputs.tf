output "dns" {
  description = "The FQDN of the newly created NLB"
  value       = "${var.dns_name}.${var.dns_zone}"
}

output "nlb_id" {
  description = "The ID for the NLB which has been created"
  value       = "${aws_lb.balancer.id}"
}

output "nlb_arn" {
  description = "The AWS ARN of the NLB which has been created"
  value       = "${aws_lb.balancer.arn}"
}

output "nlb_name" {
  description = "The name of the network load balancer we are creating"
  value       = "${var.name}-${var.environment}"
}

output "nlb_dns_name" {
  description = "The name given to the NLB just created"
  value       = "${aws_lb.balancer.dns_name}"
}

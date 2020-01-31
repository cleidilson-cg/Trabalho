output "aws_vpc_environment_id" {
  value = "${data.aws_vpc.environment.*.id}"
}

output "aws_subnet_ids_public" {
  #value = ["${data.aws_subnet_ids.public.ids}"]
  value = "${join(",", data.aws_subnet_ids.public.*.id)}"
}

output "aws_subnet_public_id" {
  value = "${data.aws_subnet.public.*.id}"
}

output "aws_subnet_ids_private" {
  #value       = ["${data.aws_subnet_ids.private.ids}"]
  value = "${join(",", data.aws_subnet_ids.private.*.id)}"
}

output "aws_subnet_private_id" {
  value = "${data.aws_subnet.private.*.id}"
}

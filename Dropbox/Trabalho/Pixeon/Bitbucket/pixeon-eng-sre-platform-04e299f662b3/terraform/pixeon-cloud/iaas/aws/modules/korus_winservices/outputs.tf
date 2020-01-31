 output "instances_id" {
  value = "${module.korus_winservices.id}"
} 

# output "public_ip" {
#   value = "${aws_eip.winservices.public_ip}"
# } 
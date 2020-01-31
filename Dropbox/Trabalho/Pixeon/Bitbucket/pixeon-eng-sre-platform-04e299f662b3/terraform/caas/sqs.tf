resource "aws_sqs_queue" "rancher_hosts_queue" {
  name                        = "rancher_hosts_terminated.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

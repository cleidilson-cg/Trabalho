## Create a listen and target group for each of the target_groups
resource "aws_lb_target_group" "target_groups_backend" {
  count = "${length(var.target_groups_backend)}"

  name                 = "${lookup(var.target_groups_backend[count.index], "target_group")}"
  deregistration_delay = "${var.deregistration_delay}"
  port                 = "${lookup(var.target_groups_backend[count.index], "target_port")}"
  protocol             = "HTTP"
  vpc_id               = "${data.aws_vpc.environment.id}"

  health_check = {
    interval            = "${var.health_check_interval}"
    protocol            = "HTTP"
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
  }

  tags = "${var.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "korus_listener_rules_backend" {
  count = "${length(var.target_groups_backend)}"

  listener_arn = "${aws_lb_listener.listeners_no_ssl.arn}"
  priority     = "${70 - count.index}"
  
  action {
    type             = "forward"
    target_group_arn = "${element(aws_lb_target_group.target_groups_backend.*.arn, count.index)}"
  }

  condition {
    field  = "host-header"
    values = ["${lookup(var.target_groups_backend[count.index], "host_header")}"]
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "korus_target_backend_attachment_A" {
  count = "${length(var.target_groups_backend)}"
  
  target_group_arn  = "${element(aws_lb_target_group.target_groups_backend.*.arn, count.index)}"
  #target_id         = "${element(var.target_id_backend, 0)}"
  target_id         = "${element(var.target_id_backend_A, 0)}"
  
  port              = "${lookup(var.target_groups_backend[count.index], "target_port")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "korus_target_backend_attachment_B" {
  count  = "${length(var.target_id_backend_B) > 0 ? length(var.target_groups_backend) : 0}"
  
  target_group_arn  = "${element(aws_lb_target_group.target_groups_backend.*.arn, count.index)}"
  #target_id         = "${element(var.target_id_backend, 1)}"
  target_id         = "${element(var.target_id_backend_B, 0)}"
  
  port              = "${lookup(var.target_groups_backend[count.index], "target_port")}"

  lifecycle {
    create_before_destroy = true
  }
}


module "korus_global_variables" {
  source = "../korus_global_variables"

}

## Create a laod balancer
resource "aws_lb" "balancer" {

  depends_on = ["module.korus_global_variables"]

  name                             = "${var.name}"
  enable_cross_zone_load_balancing = "true"
  internal                         = "${var.internal}"
  load_balancer_type               = "${var.load_balancer_type}"
  subnets                          = ["${data.aws_subnet_ids.public.ids}"]
  security_groups                  = ["${aws_security_group.pixeon_korus_alb_sg.id}"]

  # access_logs {
  #   bucket = "pixeon-cloud-logs/korus/elb/dev"
  # }

  tags = "${var.tags}"

  lifecycle {
    create_before_destroy = true
  }
}


## Create the listener for the target group
# SSL
resource "aws_lb_listener" "listeners_ssl" {
  count = "${length(var.listeners)}"

  load_balancer_arn = "${aws_lb.balancer.arn}"
  port              = "${lookup(var.listeners[count.index], "port")}"
  protocol          = "${lookup(var.listeners[count.index], "protocol")}"

  certificate_arn = "${var.certificate_arn}"

  default_action {
    target_group_arn = "${element(aws_lb_target_group.target_groups_frontend.*.arn, count.index)}"
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# HTTP
resource "aws_lb_listener" "listeners_no_ssl" {
  load_balancer_arn = "${aws_lb.balancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${element(aws_lb_target_group.target_groups_frontend.*.arn, count.index)}"
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = true
  }

  #default_action {
  #  type = "redirect"
  #  redirect {
  #    port        = "443"
  #    protocol    = "HTTPS"
  #    status_code = "HTTP_301"
  #  }
  # }
}

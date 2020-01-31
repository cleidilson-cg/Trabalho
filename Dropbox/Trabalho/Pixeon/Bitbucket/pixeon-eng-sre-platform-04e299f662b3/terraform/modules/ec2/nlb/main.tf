# Get a list of NLB subnets
data "aws_subnet_ids" "selected" {
  vpc_id = "${var.vpc_id}"
  tags   = "${var.subnet_tags}"
}

# Get the host zone id
data "aws_route53_zone" "selected" {
  name = "${var.dns_zone}"
}

# Get instances to attach in target group
data "aws_instances" "selected" {
  instance_tags = "${var.ec2_tags}"
}

## Create a listen and target group for each of the listeners
resource "aws_lb_target_group" "target_groups" {
  count = "${length(var.listeners)}"

  name                 = "${lookup(var.listeners[count.index], "target_group")}"
  deregistration_delay = "${var.deregistration_delay}"
  port                 = "${lookup(var.listeners[count.index], "target_port")}"
  protocol             = "TCP"
  vpc_id               = "${var.vpc_id}"

  health_check = {
    interval            = "${var.health_check_interval}"
    protocol            = "TCP"
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
  }

  tags = {
    Creation-Tool = "terraform"
    Env           = "${var.environment}"
  }
}

resource "aws_lb_target_group_attachment" "target_groups" {
  count = "${length(data.aws_instances.selected.ids)}"

  target_group_arn = "${aws_lb_target_group.target_groups.arn}"
  target_id        = "${element(data.aws_instances.selected.ids, count.index)}"
  port             = "${lookup(var.listeners[count.index], "port")}"
}

## Create the listener for the target group
resource "aws_lb_listener" "listeners" {
  count = "${length(var.listeners)}"

  load_balancer_arn = "${aws_lb.balancer.arn}"
  port              = "${lookup(var.listeners[count.index], "port")}"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${element(aws_lb_target_group.target_groups.*.arn, count.index)}"
    type             = "forward"
  }
}

resource "aws_lb" "balancer" {
  name                             = "${var.name}-${var.environment}"
  enable_cross_zone_load_balancing = "true"
  internal                         = "${var.internal}"
  load_balancer_type               = "network"
  subnets                          = ["${data.aws_subnet_ids.selected.ids}"]

  tags = {
    Creation-Tool = "terraform"
    Env           = "${var.environment}"
  }
}

## Create a DNS entry for this NLB
resource "aws_route53_record" "dns_nlb" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.dns_nlb == "" ? var.name : var.dns_nlb}"
  type    = "${var.dns_type}"

  alias {
    name                   = "${aws_lb.balancer.dns_name}"
    zone_id                = "${aws_lb.balancer.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dns_alias_nlb" {
  count = "${length(var.dns_alias_nlb)}"

  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${element(var.dns_alias_nlb, count.index) == "" ? var.name : element(var.dns_alias_nlb, count.index)}"
  type    = "${var.dns_type}"

  alias {
    name                   = "${var.dns_nlb}.${data.aws_route53_zone.selected.name}"
    zone_id                = "${data.aws_route53_zone.selected.zone_id}"
    evaluate_target_health = true
  }
}

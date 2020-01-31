/* Rancher Load Balance */

resource "aws_elb" "rancher_elb" {
  name            = "caas2-${var.stack_env}"
  security_groups = ["${aws_security_group.publicsg.id}"]
  subnets         = ["${aws_subnet.subnet-B-public.id}", "${aws_subnet.subnet-C-public.id}"]

  listener {
    instance_port      = 8080
    instance_protocol  = "tcp"
    lb_port            = 443
    lb_protocol        = "ssl"
    ssl_certificate_id = "${var.certificate_arn}"
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 10
    target              = "TCP:8080"
    interval            = 30
  }

  instances                   = ["${aws_instance.rancher-A.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name          = "${var.stack_name} rancher load balance"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}

resource "aws_proxy_protocol_policy" "websockets" {
  load_balancer  = "${aws_elb.rancher_elb.name}"
  instance_ports = ["8080"]
}

/* Ansible ELB */


/*

resource "aws_elb" "ansible_elb" {
  name               = "p-ansible-${var.stack_env}"
  security_groups = ["${aws_security_group.publicsg.id}"]
  subnets         = [ "${aws_subnet.subnet-B-public.id}", "${aws_subnet.subnet-C-public.id}" ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  listener {
    instance_port      = 80
    instance_protocol  = "tcp"
    lb_port            = 443
    lb_protocol        = "ssl"
    ssl_certificate_id = "${var.certificate_arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.ansible.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
        Name = "${var.stack_name} Ansible Load Balance"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
  }
}

*/


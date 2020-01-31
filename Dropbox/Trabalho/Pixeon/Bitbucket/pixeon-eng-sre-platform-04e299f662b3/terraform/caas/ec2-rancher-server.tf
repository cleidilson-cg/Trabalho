# AMI latest Ubuntu 14.04

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

/* Rancher Server Instance */

resource "aws_instance" "rancher-A" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.sgnat.id}", "${aws_security_group.rancher_server.id}"]
  subnet_id              = "${aws_subnet.subnet-B-private.id}"
  user_data              = "${data.template_file.userdata_rancher.rendered}"
  key_name               = "${var.ssh_key_name}"
  iam_instance_profile   = "${aws_iam_instance_profile.rancher_server.name}"

  tags {
    Name          = "rancher-server"
    Creation-Tool = "terraform"
    Environment   = "${var.stack_env}"
    Squad         = "sre"
  }

  depends_on = ["aws_iam_instance_profile.rancher_server"]
}

data "template_file" "userdata_rancher" {
  template = "${file("${path.module}/files/userdata_rancher_server.template")}"

  vars {
    rancher_database_address  = "${aws_route53_record.rancher_db_dns.name}"
    rancher_database_port     = "${aws_rds_cluster.db_cluster.port}"
    rancher_database_name     = "${var.rancher_db_name}"
    database_root_username    = "${var.db_user}"
    database_root_password    = "${var.db_pass}"
    rancher_database_username = "${var.rancher_db_user}"
    rancher_database_password = "${var.rancher_db_pass}"
    rancher_version           = "${var.rancher_version}"
  }
}

/* Ansible Server Instance */


/*
resource "aws_instance" "ansible" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sgnat.id}"] 
  subnet_id = "${aws_subnet.subnet-B-private.id}"
  key_name = "pixeon-production"
  tags {
        Name = "p-ansilble-server"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
  }
}

*/


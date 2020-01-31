resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.stack_name}"
  subnet_ids = ["${aws_subnet.subnet-B-private.id}", "${aws_subnet.subnet-C-private.id}"]

  tags {
    Name          = "${var.stack_name} db subnet group"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}

resource "aws_rds_cluster_parameter_group" "cluster_db_param" {
  name   = "${var.stack_name}-${var.stack_env}"
  family = "aurora5.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  tags {
    Name          = "${var.stack_name} db cluster"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}

resource "aws_rds_cluster_instance" "db_instance" {
  count              = 1
  identifier         = "${var.stack_name}-${count.index}"
  cluster_identifier = "${aws_rds_cluster.db_cluster.id}"
  instance_class     = "db.t2.small"
  apply_immediately  = true

  tags {
    Name          = "${var.stack_name} db instance"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}

resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier              = "${var.stack_name}-db-cluster"
  database_name                   = "${var.rancher_db_name}"
  backup_retention_period         = 3
  preferred_maintenance_window    = "Mon:02:00-Mon:03:00"
  preferred_backup_window         = "04:00-04:30"
  final_snapshot_identifier       = "${var.stack_name}-aurora-cluster"
  db_subnet_group_name            = "${aws_db_subnet_group.db_subnet.name}"
  master_username                 = "${var.db_user}"
  master_password                 = "${var.db_pass}"
  vpc_security_group_ids          = ["${aws_security_group.sgdb.id}"]
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.cluster_db_param.name}"

  lifecycle {
    ignore_changes = ["master_password"]
  }

  tags {
    Name          = "${var.stack_name} db cluster"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}

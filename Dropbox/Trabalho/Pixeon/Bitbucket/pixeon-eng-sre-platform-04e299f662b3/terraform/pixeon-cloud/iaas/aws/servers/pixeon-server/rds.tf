
resource "aws_db_instance" "pixeoninstance" {
    allocated_storage        = "${var.rds_volume_size}" # gigabytes
    backup_retention_period  = 7   # in days
    db_subnet_group_name     = "pixeon-cloud-test-public"
    engine                   = "postgres"
    engine_version           = "9.6.10"
    identifier               = "tstpixjirards01"
    instance_class           = "db.t2.medium"
    multi_az                 = false
    name                     = "tstpixjirards01"
    parameter_group_name     = "default.postgres9.6"
    username                 = "pixeonadmin"
    password                 = "Dts+9z#yDn98Z!Tt" #"${trimspace(file("${path.module}/secrets/mydb1-password.txt"))}"
    port                     = 5432
    publicly_accessible      = true
    storage_encrypted        = true # you should always do this
    storage_type             = "gp2"
    
    skip_final_snapshot = true
    final_snapshot_identifier = "tstpixjirards01-${var.stack_env}"
    

    vpc_security_group_ids   = ["${aws_security_group.pixeon_db_security_group.id}"]

    lifecycle {
        ignore_changes  = ["password"]
    }

    tags {
        Name            = "tstpixjirards01"
        Creation-Tool   = "terraform"
        Env             = "${var.stack_env}"
        Squad           = "${var.squad}"
    }
}


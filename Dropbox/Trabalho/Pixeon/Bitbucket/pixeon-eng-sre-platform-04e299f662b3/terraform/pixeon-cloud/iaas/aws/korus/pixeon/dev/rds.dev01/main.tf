locals {
    name                         = "devkorusrds01"
    aws_region                   = "us-east-1"
    aws_profile                  = "pixeon"
    rds_volume_size              = "50" # gigabytes
    rds_backup_retention_period  = "7" # in days
    rds_engine                   = "sqlserver-web"
    rds_engine_version           = "12.00.5571.0.v1"
    rds_instance_class           = "db.t2.small"
    rds_multi_az                 = false
    rds_parameter_group_name     = "default"
    rds_username                 = "pixeonadmin"
    rds_password                 = "Dts+9z#yDn98Z!Tt" #"${trimspace(file("${path.module}/secrets/mydb1-password.txt"))}"
    rds_port                     = "1433"
    rds_publicly_accessible      = false
    stack_name                   = "korus_rds_dev01"
    stack_env                    = "dev"
    squad                        = "sre"
}

# /* RDS Database Microsoft SQL Server to System Korus */
module "korus_rds_dev01" {
    source      = "../../../modules/korus_rds"

    aws_region  = "${local.aws_region}"
    aws_profile = "${local.aws_profile}"
    name        = "${local.name}"

    volume_size              = "${local.rds_volume_size}"
    backup_retention_period  = "${local.rds_backup_retention_period}"
    engine                   = "${local.rds_engine}"
    engine_version           = "${local.rds_engine_version}"
    instance_class           = "${local.rds_instance_class}"
    multi_az                 = "${local.rds_multi_az}"
    parameter_group_name     = "${local.rds_parameter_group_name}"
    username                 = "${local.rds_username}"
    password                 = "${local.rds_password}"
    port                     = "${local.rds_port}"
    publicly_accessible      = "${local.rds_publicly_accessible}"

    stack_name               ="${local.stack_name}_rds"
    stack_env                ="${local.stack_env}"
    squad                    ="${local.squad}"

}
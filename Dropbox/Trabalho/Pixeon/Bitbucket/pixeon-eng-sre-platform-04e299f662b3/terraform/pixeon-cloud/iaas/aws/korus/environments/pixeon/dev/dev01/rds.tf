/* RDS Korus DEV */
module "korus_rds_dev" {
    source = "../../../modules/korus_rds"

    aws_region = "${local.aws_region}"
    aws_profile = "${local.aws_profile}"
    name="${local.name_all}rds"


    volume_size              = "5" # gigabytes
    backup_retention_period  = "7" # in days
    db_subnet_group_name     = "pixeon-cloud-test-public"
    engine                   = "sqlserver-web"
    engine_version           = "14.00.1000.169.v1"
    instance_class           = "db.t2.small"
    multi_az                 = false
    parameter_group_name     = "default.mysql5.7"
    username                 = "pixeonadmin"
    password                 = "Dts+9z#yDn98Z!Tt" #"${trimspace(file("${path.module}/secrets/mydb1-password.txt"))}"
    port                     = "1433"
    publicly_accessible      = true

    stack_name="${local.stack_name}_rds"
    stack_env="${local.stack_env}"
    squad="${local.squad}"

}
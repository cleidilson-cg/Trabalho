# /* RDS Database Microsoft SQL Server to System Korus */
module "korus_rds" {
    source = "../../korus_rds"

    aws_region = "${var.aws_region}"
    aws_profile = "${var.aws_profile}"
    name="${var.name_all}"

    volume_size              = "${var.rds_volume_size}"
    backup_retention_period  = "${var.rds_backup_retention_period}"
    engine                   = "${var.rds_engine}"
    engine_version           = "${var.rds_engine_version}"
    instance_class           = "${var.rds_instance_class}"
    multi_az                 = "${var.rds_multi_az}"
    parameter_group_name     = "${var.rds_parameter_group_name}"
    username                 = "${var.rds_username}"
    password                 = "${var.rds_password}"
    port                     = "${var.rds_port}"
    publicly_accessible      = "${var.rds_publicly_accessible}"

    stack_name="${var.stack_name}_rds"
    stack_env="${var.stack_env}"
    squad="${var.squad}"

}
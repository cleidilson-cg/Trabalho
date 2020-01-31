
module "korus_rds" {
    source              = "terraform-aws-modules/rds/aws"
    version             = "1.22.0"

    identifier          = "${var.name}"

    engine              = "${var.engine}"
    engine_version      = "${var.engine_version}"
    instance_class      = "${var.instance_class}"
    allocated_storage   = "${var.volume_size}" 
    multi_az            = "${var.multi_az}" 
    storage_type        = "${var.volume_type}"
    license_model       = "license-included"

    #name                = "${var.name}" MSSQL not allowed
    username            = "${var.username}" 
    password            = "${var.password}" 
    port                = "${var.port}" 
    publicly_accessible = "${var.publicly_accessible}"

    iam_database_authentication_enabled = false

    vpc_security_group_ids = ["${aws_security_group.korus_db_security_group.id}"]

    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_window      = "03:00-06:00"

    create_monitoring_role = false
    #monitoring_interval = "30"
    #monitoring_role_name = "MyRDSMonitoringRole"

    # DB subnet group
    subnet_ids = ["${data.aws_subnet_ids.private.ids}"]

    # DB parameter group
    parameter_group_name = "default.sqlserver-web-12.0"

    # DB option group
    #option_group_name = "default:sqlserver-web-12-00"
    option_group_name = "${coalesce(aws_db_option_group.this.id , "default:sqlserver-web-12-00")}"
    #major_engine_version = "12.00"

    # Snapshot name upon DB deletion
    timezone                  = "Central Brazilian Standard Time"

    # Database Deletion Protection
    deletion_protection = false

    tags {
        Name            = "${var.name}"
        Creation-Tool   = "terraform"
        Env             = "${var.stack_env}"
        Squad           = "${var.squad}"
    }

    
    # options = [
    #     {
    #         option_name = "SQLSERVER_BACKUP_RESTORE"
    #         option_settings = [
    #             {
    #             name = "IAM_ROLE_ARN"
    #             value = "${aws_iam_role.korus_rds_role.arn}"
    #             },
    #         ]
    #     }
    # ]

    # parameters = [S
    # {
    #     name = "character_set_client"
    #     value = "utf8"
    # },
    # {
    #     name = "character_set_server"
    #     value = "utf8"
    # }
    # ]

    
    # options = [
    # {
    #     option_name = "MARIADB_AUDIT_PLUGIN"

    #     option_settings = [
    #     {
    #         name  = "SERVER_AUDIT_EVENTS"
    #         value = "CONNECT"
    #     },
    #     {
    #         name  = "SERVER_AUDIT_FILE_ROTATIONS"
    #         value = "37"
    #     },
    #     ]
    # },
    # ]
}

resource "aws_db_option_group" "this" {

    name                     = "${var.name}-option-group"
    option_group_description = "Terraform Option Group"
    engine_name              = "${var.engine}"
    major_engine_version     = "12.00"

    # option {
    #     option_name = "Timezone"

    #     option_settings {
    #     name  = "TIME_ZONE"
    #     value = "UTC"
    #     }
    # }

    option {
        option_name = "SQLSERVER_BACKUP_RESTORE"

        option_settings {
        name  = "IAM_ROLE_ARN"
        value = "${aws_iam_role.korus_rds_role.arn}"
        }
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_iam_role" "korus_rds_role" {
    name = "${var.name}_role"
    assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}

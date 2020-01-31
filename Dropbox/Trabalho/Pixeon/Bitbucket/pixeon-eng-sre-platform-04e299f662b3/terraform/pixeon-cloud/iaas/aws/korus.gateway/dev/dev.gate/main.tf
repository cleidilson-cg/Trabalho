locals {
  name_all="devkorusgateway"
}

module "dev_gateway" {
  source = "../../../modules/korus_enviroments/dev_default"

  # Global
  aws_region = "us-east-1"
  aws_profile = "pixeon"

  stack_name="korus_gateway_dev"
  stack_env="dev"
  squad="Pixeon"

  name_all="${local.name_all}"
  host_header="korus-dev-gate.pixeon.cloud"

  lb_name="${local.name_all}-alb"
  lb_certificate_arn = "arn:aws:acm:us-east-1:708426649097:certificate/4bb330c0-11d4-4995-ba9c-aa7abca64f0d"

  korus_from_port="8800"
  korus_to_port="8820"
  
  ## Frontend
  instance_type_front="t2.large"
  ami_front_A="ami-02b411190e42cf724"
  ami_front_B="ami-02b411190e42cf724"

  ## RDS
  rds_volume_size              = "20" # gigabytes
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

  ## Chef
  chef_environment     = "pixeon_cloud_dev"
  chef_run_list        = ["role[korus_app_front]"]
  chef_node_name       = "${upper(local.name_all)}"
  chef_server_url      = "https://chef.pixeon.cloud/organizations/pixeon"
  chef_user_name       = "sre"
  chef_recreate_client = true
  chef_user_key        = "${file("../../../../../chef/sre.pem")}"
  chef_attributes_json = <<EOF
    {
      "tags": [
      "korus"
    ]
    }
  EOF

  chef_connection_type = "winrm"
  chef_connection_user = "rundeck"
  chef_connection_password = "6&2a8q&zRVz4bLEBKVXr"

}

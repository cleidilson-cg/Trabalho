locals {
    name_all= "prdpixrdkslvwin"
    aws_region= "sa-east-1"
    aws_profile= "pixeon"
    domain_zone="pixeon.cloud"
    stack_name= "rundeck_slave_win"
    stack_env= "prod"
    squad= "sre"
    instance_type="t3.small"
    ami="ami-07ca83d4d1457300d"
    volume_size="100"

    ## Chef
    chef_environment     = "pixeon_cloud_prod"
    chef_run_list        = ["recipe[rundeck_slave_win]"]
    chef_node_name       = "${upper(local.name_all)}"
    chef_server_url      = "https://chef.pixeon.cloud/organizations/pixeon"
    chef_user_name       = "sre"
    chef_recreate_client = true
    chef_user_key        = "${file("../../../../../chef/sre.pem")}"
    chef_attributes_json = ""
    chef_connection_type = "winrm"
    chef_connection_user = "rundeck"
    chef_connection_password = "6&2a8q&zRVz4bLEBKVXr"
    chef_rerun="false"

    
}

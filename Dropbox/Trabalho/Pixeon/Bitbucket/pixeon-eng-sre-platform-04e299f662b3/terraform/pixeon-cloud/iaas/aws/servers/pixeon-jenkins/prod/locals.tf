locals {
    name_all= "prdpixjenkinsslavelnx01"
    aws_region= "sa-east-1"
    aws_profile= "pixeon"
    domain_zone="pixeon.cloud"
    stack_name= "pixeon-jenkins-slave-lnx"
    stack_env= "prod"

    squad= "sre"

    app_name="jenkins-slave-lnx"

    billing="pixeon"

    instance_type="t3.micro"
    ami="ami-03c6239555bb12112"
    volume_size="50"
    ## Chef
    chef_environment     = "pixeon_cloud_prod"
    chef_run_list        = ["role[pixeon_jenkins-slave]"]
    chef_node_name       = "${upper(local.name_all)}"
    chef_server_url      = "https://chef.pixeon.cloud/organizations/pixeon"
    chef_user_name       = "sre"
    chef_recreate_client = true
    chef_user_key        = "${file("../../../../../chef/sre.pem")}"
    chef_attributes_json = ""
    chef_connection_type = "ssh"
    chef_connection_user = "ubuntu"
    chef_connection_password = ""
    chef_rerun="false"

    
}

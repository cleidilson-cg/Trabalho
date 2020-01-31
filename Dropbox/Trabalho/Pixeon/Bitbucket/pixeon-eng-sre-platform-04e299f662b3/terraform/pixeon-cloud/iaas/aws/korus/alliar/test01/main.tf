locals {
  name_all="tstalliarpleres01"
  domain_zone="pleres.net"
  chef_rerun="false"
  recreate_chef_client = "true"
  chef_run_list=["recipe[korus_app]"]

}

module "test_pleres_01" {
  source = "../../../modules/korus_enviroments/test_alliar_default"

  # Global
  aws_region = "sa-east-1"
  aws_profile = "alliar"

  stack_name="${local.name_all}"
  stack_env="test"
  stack_vpc="prod"
  squad="Pixeon"

  name_all="${local.name_all}"
  domain_zone="${local.domain_zone}"

  lb_name="${local.name_all}-alb"

  korus_from_port="8800"
  korus_to_port="8820"
  # DNS

  domain_zone="pleres.net"

  # ## Winservices
  instance_type_winservices="t2.small"
  ami_winservices="ami-069fb187f19a2ca0e"

  ## Frontend
  instance_type_front="t2.small"
  ami_front_A="ami-0566322f15648c961"
  #ami_front_B="ami-07ca83d4d1457300d"

  # ## Backend
  # instance_type_back="t2.large"
  # ami_back_A="ami-05f5c28bb6992ab4b"
  # ami_back_B="ami-05f5c28bb6992ab4b"

  associate_public_ip_address = false
  assign_eip_address = false

  environments = [ "Mostarda" ]

  # ALB

  target_groups_frontend = [
    # mostarda
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mostarda-home"
      host_header     = "home.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-pleres"
      host_header     = "pleres.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-sac"
      host_header     = "sac.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-bussola"
      host_header     = "bussola.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-quest"
      host_header     = "questionario.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-wcf"
      host_header     = "wcf.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-agend"    
      host_header     = "agendamento.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-rol"
      host_header     = "rol.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-painel"
      host_header     = "painelsenha.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-mobile"
      host_header     = "mobile.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-cent-ws"
      host_header     = "wscentral.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-api-apo"
      host_header     = "apiapoiado.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-apoiado"
      host_header     = "apoiado.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-doc-api"
      host_header     = "apidoc.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-laudo"
      host_header     = "apilaudo.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-rel-api"
      host_header     = "apirelatorio.mostarda.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-central"
      host_header     = "central.mostarda.${local.domain_zone}"
    }

   ]

  target_groups_winservices = [
    {
      target_port     = "80"
      target_group    = "${local.name_all}-mosta-wcfafip"
      host_header     = "wcfafip.mostarda.${local.domain_zone}"
    }
  ]

  ## Route53
  route53_records_dns = [
        ########
        # mostarda
        ########
        {
        records         = "winservices.${local.name_all}.${local.domain_zone}"
        dns_name        = "winservices.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },   
        {
        records         = "winservices.${local.name_all}.${local.domain_zone}"
        dns_name        = "share.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },       
        {
        records         = "front-a.${local.name_all}.${local.domain_zone}"
        dns_name        = "front-a.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "front-b.${local.name_all}.${local.domain_zone}"
        dns_name        = "front-b.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "home.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "pleres.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "sac.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "bussola.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "questionario.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "wcf.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "agendamento.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "rol.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "painelsenha.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "mobile.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "wscentral.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apiapoiado.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apoiado.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apidoc.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apilaudo.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apirelatorio.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "central.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "${local.domain_zone}"
        dns_name        = "wcfauth.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "wcfrelatorio.alliar.pleres.net"
        dns_name        = "wcfrelatorio.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "${local.domain_zone}"
        dns_name        = "cep.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        { 
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "wcfafip.mostarda.${local.domain_zone}"
        dns_type        = "CNAME"
        }

    ]


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
  chef_environment     = "customer_alliar_test"
  chef_run_list        = ["${local.chef_run_list}"]
  chef_node_name       = "${upper(local.name_all)}"
  chef_server_url      = "https://chef.pixeon.cloud/organizations/pixeon"
  chef_user_name       = "sre"
  chef_recreate_client = "${local.recreate_chef_client}"
  chef_user_key        = "${file("${path.module}/../../../../chef/sre.pem")}"
  chef_attributes_json_front_a = "${data.template_file.chef_attributes_front_a.rendered}"
  chef_attributes_json_front_b = "${data.template_file.chef_attributes_front_a.rendered}"
  chef_attributes_json_winservices = "${data.template_file.chef_attributes_winservices.rendered}"


  chef_connection_type = "winrm"
  chef_connection_user = "chef-user"
  chef_connection_password = "Maestro@Password*5842"
  chef_rerun="${local.chef_rerun}"
}

data "template_file" "chef_attributes_front_a" {
  template = "${file("${path.module}/files/front_attributes.json")}"

  vars {
    name_all = "${local.name_all}"
  }
}

data "template_file" "chef_attributes_front_b" {
  template = "${file("${path.module}/files/front_attributes.json")}"

  vars {
    name_all = "${local.name_all}"
  }
}

data "template_file" "chef_attributes_winservices" {
  template = "${file("${path.module}/files/winservices_attributes.json")}"

  vars {
    name_all = "${local.name_all}"
  }
}


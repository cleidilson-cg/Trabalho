locals {
  name_all="prdalliarpleres01"
  domain_zone="pleres.net"
  chef_rerun="false"
  recreate_chef_client = "true"
  chef_run_list=["recipe[korus_app]"]

}

module "prd_pleres_01" {
  source = "../../../modules/korus_enviroments/prod_alliar_default"

  # Global
  aws_region = "sa-east-1"
  aws_profile = "alliar"

  stack_name="${local.name_all}"
  stack_vpc="prod"
  stack_env="prod"
  squad="Pixeon"

  name_all="${local.name_all}"
  domain_zone="${local.domain_zone}"

  lb_name="${local.name_all}-alb"

  korus_from_port="8800"
  korus_to_port="8820"
  # DNS

  domain_zone="pleres.net"

  # ## Winservices
  instance_type_winservices="t2.large"
  ami_winservices="ami-069fb187f19a2ca0e"

  ## Frontend
  instance_type_front="t2.large"
  ami_front_A="ami-0566322f15648c961"
  #ami_front_B="ami-07ca83d4d1457300d"

  # ## Backend
  # instance_type_back="t2.large"
  # ami_back_A="ami-05f5c28bb6992ab4b"
  # ami_back_B="ami-05f5c28bb6992ab4b"

  associate_public_ip_address = false
  assign_eip_address = false

  environments = [ "Jambo" ]

  # ALB

  target_groups_frontend = [
    # JAMBO
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-home"
      host_header     = "home.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-pleres"
      host_header     = "pleres.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-sac"
      host_header     = "sac.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-bussola"
      host_header     = "bussola.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-quest"
      host_header     = "questionario.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-wcf"
      host_header     = "wcf.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-agend"    
      host_header     = "agendamento.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-rol"
      host_header     = "rol.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-painel"
      host_header     = "painelsenha.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-mobile"
      host_header     = "mobile.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-cent-ws"
      host_header     = "wscentral.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-api-apo"
      host_header     = "apiapoiado.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-apoiado"
      host_header     = "apoiado.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-doc-api"
      host_header     = "apidoc.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-laudo"
      host_header     = "apilaudo.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-rel-api"
      host_header     = "apirelatorio.jambo.${local.domain_zone}"
    },
    {
      target_port     = "80"
      target_group    = "${local.name_all}-jambo-central"
      host_header     = "central.jambo.${local.domain_zone}"
    }
   ]

  ## Route53
  route53_records_dns = [
        ########
        # JAMBO
        ########
        {
        records         = "winservices.${local.name_all}.${local.domain_zone}"
        dns_name        = "winservices.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },   
        {
        records         = "winservices.${local.name_all}.${local.domain_zone}"
        dns_name        = "share.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },       
        {
        records         = "front-a.${local.name_all}.${local.domain_zone}"
        dns_name        = "front-a.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "front-b.${local.name_all}.${local.domain_zone}"
        dns_name        = "front-b.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "home.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "pleres.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "sac.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "bussola.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "questionario.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "wcf.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "agendamento.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "rol.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "painelsenha.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "mobile.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "wscentral.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apiapoiado.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apoiado.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apidoc.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apilaudo.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "apirelatorio.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "alb.${local.name_all}.${local.domain_zone}"
        dns_name        = "central.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "${local.domain_zone}"
        dns_name        = "wcfauth.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "wcfrelatorio.alliar.pleres.net"
        dns_name        = "wcfrelatorio.jambo.${local.domain_zone}"
        dns_type        = "CNAME"
        },
        {
        records         = "${local.domain_zone}"
        dns_name        = "cep.jambo.${local.domain_zone}"
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
  chef_environment     = "customer_alliar_prod"
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


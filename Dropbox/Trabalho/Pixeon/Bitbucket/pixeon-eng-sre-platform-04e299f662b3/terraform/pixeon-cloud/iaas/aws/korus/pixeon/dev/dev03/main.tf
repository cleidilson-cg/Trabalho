locals {
  name_all="devpixkorus003"
  stack_name="korus-dev03"
  chef_rerun="true"
}

module "dev03" {
  source = "../../../modules/korus_enviroments/dev_default"

  # Global
  aws_region = "us-east-1"
  aws_profile = "pixeon"

  stack_name="${local.stack_name}"
  stack_env="dev"
  squad="sre"

  name_all="${local.name_all}"

  lb_name="${local.name_all}-alb"

  korus_from_port="8800"
  korus_to_port="8820"
  
  #DNS 

  domain_zone = "pleres.net"

  ## Frontend
  instance_type_front="t2.large"
  ami_front_A="ami-02b411190e42cf724"

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
  rds_publicly_accessible      = true

  
  ## Chef
  chef_environment     = "pixeon_cloud_dev"
  chef_run_list        = ["recipe[korus_app]"]
  chef_node_name       = "${upper(local.name_all)}"
  chef_server_url      = "https://chef.pixeon.cloud/organizations/pixeon"
  chef_user_name       = "sre"
  chef_recreate_client = true
  chef_user_key        = "${file("../../../../../chef/sre.pem")}"
  chef_attributes_json = <<EOF
    {
            "korus_app" : {
            "sites_enabled" : ["dev03"],
            "gw" : {

                "url" : "https://dev.pleres.net",
                "db_host" : "gwdb.dev.pleres.net",
                "db_name" : "Digitalmed-Cloud",
                "db_user" : "digitalmed.cloud",
                "db_pass" : "Ni3ewM3L4Y$NeS5lSz@rU5ve"

            },
            "environments" : [
                {
                    "name" : "dev03",
                    "version" : "alliar.v2.9.2",
                    "configs_version" : "v2.9",
                    "url" : "dev01.pleres.net",
                    "customers" : [
                        {
                            "name" : "cdb",
                            "data_source" : "db.dev03.pleres.net",
                            "db_name" : "Pleres-CDB",
                            "db_user" : "pleresnet",
                            "db_pass" : "e0eAk@B5aZ"
                        },
                        {
                            "name" : "alliar",
                            "data_source" : "db.dev03.pleres.net",
                            "db_name" : "alliar",
                            "db_user" : "pleresnet",
                            "db_pass" : "dbpassword"
                        }

                    ],
                    "sites" : [
                        {
                            "name": "Web.Home",
                            "port": "8800"

                        },
                        {
                            "name": "Web.Pleres",
                            "port" :"8801"

                        },
                        {
                            "name": "Web.SAC",
                            "port": "8802"
                        },
                        {
                            "name": "Web.Bussola",
                            "port" :"8803"

                        },
                        {
                            "name": "Web.Questionario",
                            "port" :"8804"

                        },
                        {
                            "name": "Web.WCF",
                            "port": "8805"
                        },       
                        {
                            "name": "Web.Agendamento",
                            "port" :"8806"

                        },
                        {
                            "name": "Web.ROL",
                            "port" :"8807"

                        },
                        {
                            "name": "Web.Mobile",
                            "port" :"8809"

                        },
                        {
                            "name": "Web.Ws.CentralLaudos",
                            "port" :"8810"

                        },
                        {
                            "name": "Web.Api.Ui",
                            "port" :"8811"

                        },
                        {
                            "name": "Web.Api",
                            "port" :"8813"

                        }

                    ],
                    "windows_services" : [

                        {
                            "name": "SrvWin.FilaProcessamento"
                        }
                    ],
                    "filas_processamento" : [
                        {
                            "name" : "ComissaoVendedor"
                        },
                        {
                            "name" : "EntregaResultadoLote"
                        },
                        {
                            "name" : "Faturamento"
                        },
                        {
                            "name" : "FaturamentoLaboratorioApoiado"
                        },
                        {
                            "name" : "ImportacaoCadastro"
                        },
                        {
                            "name" : "Importador"
                        },
                        {
                            "name" : "IntegracaoErp"
                        },
                        {
                            "name" : "IntegracaoSadig"
                        },
                        {
                            "name" : "IntegracaoMotoboy"
                        },
                        {
                            "name" : "LaboratorioApoiado"
                        },
                        {
                            "name" : "LaboratorioApoio"
                        },
                        {
                            "name" : "Limpeza"
                        },
                        {
                            "name" : "Mensagem"
                        },
                        {
                            "name" : "NotaFiscal"
                        },
                        {
                            "name" : "PainelSenha"
                        },
                        {
                            "name" : "RepasseLote"
                        }

                    ]
                }
        ]       
    },
      "tags": [
      "korus_front_a",
      "${local.stack_name}"
    ]
    }
  EOF

  chef_connection_type = "winrm"
  chef_connection_user = "rundeck"
  chef_connection_password = "6&2a8q&zRVz4bLEBKVXr"
  chef_rerun="${local.chef_rerun}"

}

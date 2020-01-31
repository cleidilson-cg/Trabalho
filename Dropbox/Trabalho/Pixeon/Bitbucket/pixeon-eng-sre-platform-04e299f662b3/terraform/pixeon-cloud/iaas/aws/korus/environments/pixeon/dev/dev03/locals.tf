locals {
  # Global
  aws_region = "us-east-1"
  aws_profile = "pixeon"

  stack_name="korus_dev01"
  stack_env="dev"
  squad="Pixeon"

  name_all="devpixkorus001"
  host_header="korus-dev01.pixeon.cloud"

  lb_name="${local.name_all}-alb"
  lb_certificate_arn = "arn:aws:acm:us-east-1:708426649097:certificate/4bb330c0-11d4-4995-ba9c-aa7abca64f0d"

  korus_from_port="8800"
  korus_to_port="8820"
  
  ## Frontend
  instance_type_front="t2.large"
  amazon_machine_image_front_A="ami-05f5c28bb6992ab4b"
  amazon_machine_image_front_B="ami-05f5c28bb6992ab4b"

  ## Backend
  instance_type_back="t2.large"
  amazon_machine_image_back_A="ami-05f5c28bb6992ab4b"
  amazon_machine_image_back_B="ami-05f5c28bb6992ab4b"

  ## Winservices
  instance_type_winservices="t2.large"
  amazon_machine_image_winservices="ami-05f5c28bb6992ab4b"
}

## ami-0f7af6e605e2d2db5
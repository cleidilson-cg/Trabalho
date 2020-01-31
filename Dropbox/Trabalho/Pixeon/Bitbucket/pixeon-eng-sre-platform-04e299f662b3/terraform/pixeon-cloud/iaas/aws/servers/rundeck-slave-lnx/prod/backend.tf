terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/servers/rundeck_slave_lnx.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/servers/prdpixjenkins-linux-slave01-aws.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/servers/prdpixvpn01-aws.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/korus.gateway/dev/dev.gate.tfstate"
    region = "us-east-1"
  }
}

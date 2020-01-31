terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/orchestration/infra.tfstate"
    region = "us-east-1"
  }
}

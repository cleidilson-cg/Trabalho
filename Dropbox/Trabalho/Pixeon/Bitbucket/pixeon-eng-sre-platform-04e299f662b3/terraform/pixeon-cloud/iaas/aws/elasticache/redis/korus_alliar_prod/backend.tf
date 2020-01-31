terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/elasticache/redis/korus_alliar_prod.tfstate"
    region = "us-east-1"
  }
}

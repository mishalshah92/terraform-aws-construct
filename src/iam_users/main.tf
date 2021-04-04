terraform {
  required_version = "> 0.12"

  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  default_tags = {
    Env    = var.env
    Commit = var.git_commit
    Tool   = var.tool
    Repo   = var.repo
  }

  tags = merge(local.default_tags, var.tags)
}
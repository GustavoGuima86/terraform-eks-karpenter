terraform {
  backend "s3" {
    bucket = "gustavo-terraform-backend"
    key    = "eks-karpenter/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-lock"
  }
}

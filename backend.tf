terraform {
  backend "s3" {
    key = "terraform/backend/vpc-infra/vpc_infra/terraform.tfstate"
    encrypt = true
  }
}

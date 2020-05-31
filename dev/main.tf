provider "aws" {
  version = "~> 2.0"
  region  = "ap-southeast-1"
}

# Terraform Backend (Initializing step, NOT allows 'var' or 'local' here)
terraform {
  required_version = ">= 0.12.0"
}

module "tf-tgw" {
  source      = "../_module"
  env         = "dev"
  provisioner = "Terraform"

  # TGW
  amazon_side_asn            = 64512
  tgw_destination_cidr_block = "10.0.0.0/8"
  # TGW Attachment 1

  vpc1 = {
    id         = "vpc-xxxxxxxxxxxxxxxxx"
    subnet_ids = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxxx"]
    route_id   = "rtb-xxxxxxxxxxxxxxxxx"
  }

  # TGW Attachment 2
  vpc2 = {
    id         = "vpc-yyyyyyyyyyyyyyyy"
    subnet_ids = ["subnet-yyyyyyyyyyyyyyyy", "subnet-yyyyyyyyyyyyyyyy"]
    route_id   = "rtb-yyyyyyyyyyyyyyyy"
  }


}


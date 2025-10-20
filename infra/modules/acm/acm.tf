terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_acm_certificate" "this" {
  domain   = var.acm_lookup_domain
  statuses = ["ISSUED"]

  most_recent = true
}

data "aws_caller_identity" "current" {}

locals {
  suffixes = {
    iam_role   = "iam-role"
    iam_policy = "iam-policy"
    acm        = "acm"
    cloudfront = "cloudfront"
    s3_bucket  = "s3-bucket"
  }

  resource_prefixes = {
    for key, suffix in local.suffixes :
    key => "${var.project_name}-${var.environment}-${suffix}"
  }

  iam_openid_github_actions = {
    url             = "https://token.actions.githubusercontent.com"
    thumbprint_list = var.github_oidc_thumbprint_list
  }

  iam_github_actions_role = {
    federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
    string_equals = {
      variable = "token.actions.githubusercontent.com:aud"
      value    = "sts.amazonaws.com"
    }
    string_like = {
      variable = "token.actions.githubusercontent.com:sub"
      value    = "repo:${var.github_owner}/${var.github_repository}:environment:${var.environment}"
    }
  }
}

module "s3_bucket" {
  source = "./modules/s3_bucket"

  resource_prefix_s3_bucket = local.resource_prefixes.s3_bucket
  tags                      = var.default_tags
}

module "acm" {
  source = "./modules/acm"
  providers = {
    aws = aws.us_east_1
  }

  acm_lookup_domain = var.acm_lookup_domain
}

module "cloudfront" {
  source = "./modules/cloudfront"

  resource_prefix_cloudfront = local.resource_prefixes.cloudfront
  price_class                = var.cloudfront_price_class
  cloudfront_alias_domain    = var.cloudfront_alias_domain
  default_root_object        = var.cloudfront_default_root_object
  http_version               = var.cloudfront_http_version
  cache_policy_id            = var.cloudfront_cache_policy_id
  origin_request_policy_id   = var.cloudfront_origin_request_policy_id
  response_headers_policy_id = var.cloudfront_response_headers_policy_id
  tags                       = var.default_tags

  s3_bucket_regional_domain_name = module.s3_bucket.bucket_regional_domain_name
  acm_certificate_arn            = module.acm.certificate_arn
}

module "iam" {
  source = "./modules/iam"

  resource_prefix_iam_role    = local.resource_prefixes.iam_role
  s3_bucket_id                = module.s3_bucket.bucket_id
  s3_bucket_arn               = module.s3_bucket.bucket_arn
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
  iam_role_GitHubActionsRole  = local.iam_github_actions_role
  iam_openid_GitHubActions    = local.iam_openid_github_actions
  tags                        = var.default_tags
}

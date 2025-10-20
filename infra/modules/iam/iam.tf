data "aws_iam_policy_document" "s3_oac" {
  statement {
    sid       = "AllowCloudFrontReadOnlyViaOAC"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${var.s3_bucket_arn}/*"]
    principals {
      type = "Service"
      identifiers = [
        "cloudfront.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_distribution_arn]
    }
  }
}

# GitHub Actions AssumeRole (OIDC)
data "aws_iam_policy_document" "github_actions_assume" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.iam_role_GitHubActionsRole.federated]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = var.iam_role_GitHubActionsRole.string_equals.variable
      values   = [var.iam_role_GitHubActionsRole.string_equals.value]
    }

    condition {
      test     = "StringLike"
      variable = var.iam_role_GitHubActionsRole.string_like.variable
      values   = [var.iam_role_GitHubActionsRole.string_like.value]
    }
  }
}

# GitHub Actions 実行ポリシー (S3バケット 更新)
data "aws_iam_policy_document" "github_actions_policy" {
  statement {
    sid    = "CloudFrontInvalidation"
    effect = "Allow"
    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:GetDistribution",
      "cloudfront:ListInvalidations"
    ]
    resources = [
      var.cloudfront_distribution_arn
    ]
  }

  # バケットに対する権限
  statement {
    sid    = "BucketLevel"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [
      var.s3_bucket_arn
    ]
  }

  # オブジェクトに対する権限
  statement {
    sid    = "ObjectLevel"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts"
    ]
    resources = [
      "${var.s3_bucket_arn}/*"
    ]
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = var.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_oac.json
}

# GitHub Actions ロール
resource "aws_iam_role" "github_actions" {
  name               = "${var.resource_prefix_iam_role}-github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume.json
  tags               = var.tags
}

# GitHub Actions 権限ポリシー
resource "aws_iam_policy" "github_actions" {
  name   = "${var.resource_prefix_iam_role}-github-actions-policy"
  policy = data.aws_iam_policy_document.github_actions_policy.json
  tags   = var.tags
}

# GitHub Actions ポリシーアタッチメント
resource "aws_iam_role_policy_attachment" "github_actions" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions.arn
}

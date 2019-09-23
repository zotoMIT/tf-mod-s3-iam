provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

module "label" {
  source = "github.com/mitlibraries/tf-mod-name?ref=0.12"
  name   = var.name
  tags   = var.tags
}

resource "aws_s3_bucket" "default" {
  bucket        = module.label.name
  acl           = var.acl
  region        = var.region
  force_destroy = var.force_destroy
  policy        = var.policy

  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    id      = "${module.label.name}-transfer-to-IA"
    enabled = var.standard_transition_enabled

    prefix = var.standard_object_prefix

    transition {
      days          = var.standard_transition_days
      storage_class = "STANDARD_IA"
    }
  }

  lifecycle_rule {
    id      = "${module.label.name}-transfer-to-glacier"
    enabled = var.glacier_transition_enabled

    prefix = var.glacier_object_prefix

    transition {
      days          = var.glacier_transition_days
      storage_class = "GLACIER"
    }
  }

  lifecycle_rule {
    id      = "${module.label.name}-expire-object"
    enabled = var.expire_objects_enabled

    prefix = var.expire_objects_prefix

    expiration {
      days = var.expiration_days
    }
  }

  lifecycle_rule {
    id      = "${module.label.name}-noncurrent-rules"
    enabled = var.noncurrent_rules_enabled

    prefix = var.noncurrent_rules_prefix

    noncurrent_version_expiration {
      days = var.noncurrent_version_expiration_days
    }

    noncurrent_version_transition {
      days          = var.noncurrent_version_transition_days
      storage_class = "GLACIER"
    }
  }

  # https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
  # https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#enable-default-server-side-encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_id
      }
    }
  }

  tags = module.label.tags
}

#Full read/write access to S3 bucket
data "aws_iam_policy_document" "readwrite" {
  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
    resources = [aws_s3_bucket.default.arn, "${aws_s3_bucket.default.arn}/*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "readonly" {
  statement {
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = [aws_s3_bucket.default.arn, "${aws_s3_bucket.default.arn}/*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "admin" {
  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:GetObject", "s3:ListBucket", "s3:DeleteObject"]
    resources = [aws_s3_bucket.default.arn, "${aws_s3_bucket.default.arn}/*"]
    effect    = "Allow"
  }

  #This is needed for users to be able to select the bucket
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
    effect    = "Allow"
  }
}

#Create read/write, readonly, and amdin policy for S3 bucket
resource "aws_iam_policy" "readwrite" {
  name        = "${module.label.name}-readwrite"
  description = "Policy to allow IAM user read/write access to ${module.label.name} S3 bucket"
  policy      = data.aws_iam_policy_document.readwrite.json
}

resource "aws_iam_policy" "readonly" {
  name        = "${module.label.name}-readonly"
  description = "Policy to allow IAM user read only access to ${module.label.name} S3 bucket"
  policy      = data.aws_iam_policy_document.readonly.json
}

resource "aws_iam_policy" "admin" {
  name        = "${module.label.name}-admin"
  description = "Policy to allow IAM user full access to ${module.label.name} S3 bucket"
  policy      = data.aws_iam_policy_document.admin.json
}


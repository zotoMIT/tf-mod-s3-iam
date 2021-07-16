# S3 bucket with IAM policies

This module will create an S3 bucket and associated IAM policies. The created policies can then be attached to an externally created IAM user.

Bucket versioning and lifecycle rules have been separated into independent sections (IA, Glacier, expire objects) for different app needs.

## Modules

| Name | Source | Version |
|------|--------|---------|
| label | [github.com/mitlibraries/tf-mod-name](https://github.com/mitlibraries/tf-mod-name) | 0.13 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | (Optional) The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services | `string` | `"log-delivery-write"` | no |
| expiration\_days | Number of days after which to expunge the objects | `string` | `"90"` | no |
| expire\_objects\_enabled | Specifies expiration lifecycle rule status. | `string` | `"false"` | no |
| expire\_objects\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| force\_destroy | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `string` | `"false"` | no |
| glacier\_object\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | `string` | `"60"` | no |
|glacier\_transition\_enabled | Specifies Glacier transition lifecycle rule status. | `string` | `"false"` | no |
| kms\_master\_key\_id | The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms | `string` | `""` | no |
| lifecycle\_rule\_enabled | (Optional) enable lifecycle events on this bucket | `string` | `"false"` | no |
| name | Name  (e.g. `app` or `db`) | `string` | n/a | yes |
| noncurrent\_rules\_enabled | Specifies noncurrent lifecycle rule status. | `string` | `"false"` | no |
| noncurrent\_rules\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| noncurrent\_version\_expiration\_days | (Optional) Specifies when noncurrent object versions expire. | `string` | `"90"` | no |
| noncurrent\_version\_transition\_days | (Optional) Specifies when noncurrent object versions transitions | `string` | `"30"` | no |
| policy | A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. | `string` | `""` | no |
| prefix | (Optional) Key prefix. Used to manage object lifecycle events. | `string` | `""` | no |
| region | (Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee. | `string` | `""` | no |
| sse\_algorithm | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| standard\_object\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `string` | `"30"` | no |
| standard\_transition\_enabled | Specifies infrequent storage transition lifecycle rule status. | `string` | `"false"` | no |
| tags | Additional tags (e.g. map('BusinessUnit`,`XYZ`)` | `map(string)` | `{}` | no |
| versioning\_enabled | (Optional) A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket. | `string` | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_arn | ARN of admin Policy |
| bucket\_arn | Bucket ARN |
| bucket\_domain\_name | FQDN of bucket |
| bucket\_id | Bucket Name (aka ID) |
| readonly\_arn | ARN of readonly Policy |
| readwrite\_arn | ARN of readwrite Policy |

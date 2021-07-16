variable "name" {
  description = "Name  (e.g. `app` or `db`)"
  type        = string
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = string
  default     = "false"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services"
  type        = string
  default     = "log-delivery-write"
}

variable "policy" {
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy."
  type        = string
  default     = ""
}

variable "prefix" {
  description = "(Optional) Key prefix. Used to manage object lifecycle events."
  type        = string
  default     = ""
}

variable "region" {
  description = "(Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee."
  type        = string
  default     = ""
}

variable "lifecycle_rule_enabled" {
  description = "(Optional) enable lifecycle events on this bucket"
  type        = string
  default     = "false"
}

variable "versioning_enabled" {
  description = "(Optional) A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket."
  type        = string
  default     = "false"
}

variable "noncurrent_rules_enabled" {
  description = "Specifies noncurrent lifecycle rule status."
  type        = string
  default     = "false"
}

variable "noncurrent_rules_prefix" {
  description = "Object key prefix identifying one or more objects to which the lifecycle rule applies."
  type        = string
  default     = ""
}

variable "noncurrent_version_expiration_days" {
  description = "(Optional) Specifies when noncurrent object versions expire."
  type        = string
  default     = "90"
}

variable "noncurrent_version_transition_days" {
  description = "(Optional) Specifies when noncurrent object versions transitions"
  type        = string
  default     = "30"
}

variable "standard_transition_enabled" {
  description = "Specifies infrequent storage transition lifecycle rule status."
  type        = string
  default     = "false"
}

variable "standard_object_prefix" {
  description = "Object key prefix identifying one or more objects to which the lifecycle rule applies."
  type        = string
  default     = ""
}

variable "standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  type        = string
  default     = "30"
}

variable "glacier_transition_enabled" {
  description = "Specifies Glacier transition lifecycle rule status."
  type        = string
  default     = "false"
}

variable "glacier_object_prefix" {
  description = "Object key prefix identifying one or more objects to which the lifecycle rule applies."
  type        = string
  default     = ""
}

variable "glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  type        = string
  default     = "60"
}

variable "expire_objects_enabled" {
  description = "Specifies expiration lifecycle rule status."
  type        = string
  default     = "false"
}

variable "expire_objects_prefix" {
  description = "Object key prefix identifying one or more objects to which the lifecycle rule applies."
  type        = string
  default     = ""
}

variable "expiration_days" {
  description = "Number of days after which to expunge the objects"
  type        = string
  default     = "90"
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  type        = string
  default     = "AES256"
}

variable "kms_master_key_id" {
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  type        = string
  default     = ""
}


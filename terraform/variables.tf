variable "project" {
  type        = string
  description = "GCP project ID"
}

variable "code_artifacts_bucket" {
  type        = string
  description = "Name of the bucket containing the Cloud Functions `.zip` file"
}

variable "function_retry" {
  type        = bool
  description = "Enable `retry` on the function failure policy?"
  default     = false
}

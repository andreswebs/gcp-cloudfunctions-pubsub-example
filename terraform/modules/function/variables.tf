variable "region" {
  type        = string
  description = "Compute region"
}

variable "function_service_account_name" {
  type        = string
  description = "Function service account name"
  default     = "function-test-pubsub"
}

variable "function_name" {
  type        = string
  description = "Function name"
  default     = "function-test-pubsub"
}

variable "function_description" {
  type        = string
  description = "The function description"
  default     = "Test Function"
}

variable "topic_name" {
  type        = string
  description = "Name of the trigger topic"
  default     = "function-test-pubsub-trigger"
}

variable "code_artifacts_bucket" {
  type        = string
  description = "Name of the bucket containing the Cloud Functions `.zip` file"
}

variable "function_object" {
  type        = string
  description = "Bucket object path to the Cloud Functions `.zip` file"
  default     = "function-test-pubsub.zip"
}

variable "function_retry" {
  type        = bool
  description = "Enable `retry` on the function failure policy?"
  default     = false
}

variable "schedule_enabled" {
  type        = bool
  description = "(Optional) Enable schedule?"
  default     = false
}

variable "schedule_cron" {
  type        = string
  description = "Cron expression for function trigger"
  default     = "0/30 * * * *"
}

output "trigger_topic" {
  description = "The `google_pubsub_topic` triggering the cloud function"
  value       = google_pubsub_topic.function_trigger
}

output "function" {
  description = "The `google_cloudfunctions_function` resource"
  value       = google_cloudfunctions_function.this
}

output "service_account" {
  description = "IAM service account used by the cloud function"
  value       = google_service_account.this
}

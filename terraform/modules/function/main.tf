data "google_project" "this" {}

resource "google_pubsub_topic" "function_trigger" {
  name   = var.topic_name
  labels = {}
}

locals {
  scheduler_data = <<-EOT
    {
      "action": "start",
      "notify": true
    }
  EOT
}

resource "google_cloud_scheduler_job" "this" {
  count       = var.schedule_enabled ? 1 : 0
  name        = var.topic_name
  region      = var.region
  description = "function trigger"
  schedule    = var.schedule_cron

  pubsub_target {
    topic_name = google_pubsub_topic.function_trigger.id
    data       = base64encode(local.scheduler_data)
  }
}

resource "google_cloudfunctions_function" "this" {
  name                = var.function_name
  region              = var.region
  description         = var.function_description
  runtime             = "nodejs18"
  entry_point         = "main"
  timeout             = 540
  available_memory_mb = 256
  max_instances       = 5

  source_archive_bucket = var.code_artifacts_bucket
  source_archive_object = var.function_object

  service_account_email = google_service_account.this.email

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.function_trigger.id
    failure_policy {
      retry = var.function_retry
    }
  }

  environment_variables = {
    CLOUDSDK_CORE_PROJECT = data.google_project.this.project_id
  }

  labels = {}

  lifecycle {
    create_before_destroy = true
  }

}

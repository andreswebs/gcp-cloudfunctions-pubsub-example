resource "google_service_account" "this" {
  account_id   = var.function_service_account_name
  display_name = var.function_service_account_name
}

locals {
  iam_member = google_service_account.this.member
}

resource "google_project_iam_member" "log_writer" {
  project = data.google_project.this.project_id
  role    = "roles/logging.logWriter"
  member  = local.iam_member
}

resource "google_project_iam_member" "metric_writer" {
  project = data.google_project.this.project_id
  role    = "roles/monitoring.metricWriter"
  member  = local.iam_member
}

resource "google_project_iam_member" "tracer" {
  project = data.google_project.this.project_id
  role    = "roles/cloudtrace.agent"
  member  = local.iam_member
}

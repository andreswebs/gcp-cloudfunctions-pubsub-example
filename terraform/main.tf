locals {
  function_object = "function-test.zip"
  function_name   = substr("function-test-${random_string.function_suffix.result}", 0, 63)
}

data "google_storage_bucket_object" "function_artifact" {
  bucket = var.code_artifacts_bucket
  name   = local.function_object
}

resource "random_string" "function_suffix" {
  length  = 8
  special = false
  upper   = false
  keepers = {
    hash = data.google_storage_bucket_object.function_artifact.crc32c
  }
}

module "function_test" {
  source                        = "./modules/function"
  region                        = "europe-west1"
  code_artifacts_bucket         = var.code_artifacts_bucket
  topic_name                    = "function-test-trigger"
  function_service_account_name = "function-test"
  function_name                 = local.function_name
  function_object               = local.function_object
  function_retry                = var.function_retry
  schedule_enabled              = false
}

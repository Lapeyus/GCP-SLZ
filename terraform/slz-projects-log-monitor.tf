locals {
  main_logs_filter = <<EOF
    logName: /logs/cloudaudit.googleapis.com%2Factivity OR
    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR
    logName: /logs/compute.googleapis.com%2Fvpc_flows OR
    logName: /logs/compute.googleapis.com%2Ffirewall OR
    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency
EOF
  all_logs_filter  = ""
}

module "org_monitoring_project" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "14.2.0"
  random_project_id       = "true"
  name                    = "logging-monitoring-${random_string.suffix.result}"
  org_id                  = var.org_id
  billing_account         = var.billing_account
  folder_id               = module.folders.id["Logging-Monitoring"]
  default_service_account = "disable"
  activate_apis           = []
  labels = {
    terraform_managed = true
  }
}

resource "google_monitoring_dashboard" "logging_dashboards" {
  for_each       = fileset(path.module, "dashboards/*.json") #local.json_file
  project        = module.org_monitoring_project.project_id
  dashboard_json = file(each.key)
}

### Add this to projects that need to be monitored ###

# resource "google_monitoring_monitored_project" "primary" {
#   metrics_scope = "change-to-existing-metrics-scope-project"
#   name          = "logging-monitoring-3953"
# }

/******************************************
  Send logs to Storage
*****************************************/
module "storage_destination" {
  source                      = "terraform-google-modules/log-export/google//modules/storage"
  version                     = "~> 7.3.0"
  project_id                  = module.org_monitoring_project.project_id
  storage_bucket_name         = "sd-bkt-${module.org_monitoring_project.project_id}-org-logs-${random_string.suffix.result}"
  log_sink_writer_identity    = module.log_export_to_storage.writer_identity
  uniform_bucket_level_access = true
  lifecycle_rules = [
    {
      action = {
        type = "Delete"
      }
      condition = {
        age        = 365
        with_state = "ANY"
      }
    },
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
      condition = {
        age        = 180
        with_state = "ANY"
      }
    }
  ]
}

module "log_export_to_storage" {
  source          = "terraform-google-modules/log-export/google"
  version         = "~> 7.3.0"
  destination_uri = module.storage_destination.destination_uri
  #   filter                 = local.all_logs_filter
  log_sink_name          = "bmcd_logging_bkt"
  parent_resource_id     = var.org_id
  parent_resource_type   = "organization"
  include_children       = true
  unique_writer_identity = true
}

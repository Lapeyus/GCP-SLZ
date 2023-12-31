/*
### Local Variables
- `main_logs_filter`: A string representing the main logs filter. Used in different modules for specifying the logs to capture.
- `all_logs_filter`: Placeholder for additional log filters.
*/
locals {
  main_logs_filter = <<EOF
      logName: /logs/cloudaudit.googleapis.com%2Factivity OR
      logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR
      logName: /logs/compute.googleapis.com%2Fvpc_flows OR
      logName: /logs/compute.googleapis.com%2Ffirewall OR
      logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency
  EOF
}

/*
### monitoring
Creates the monitoring project using the Terraform Google Project Factory module.
#### Inputs
- `source`: The source code repository for the Terraform module.
- `version`: The version of the Terraform Google Project Factory module.
- `name`: The name of the monitoring project, suffixed by a random string.
- `org_id`, `billing_account`: GCP organization and billing account IDs.
- `folder_id`: GCP folder where the project will be located.
- `activate_apis`: List of GCP APIs to enable (empty in this example).
#### Labels
- `terraform_managed`: Indicates that Terraform manages this resource.
*/
module "monitoring" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "14.3.0"
  random_project_id       = "true"
  create_project_sa       = false
  name                    = "${var.owner}-logging-monitoring"
  org_id                  = var.org_id
  billing_account         = var.billing_account
  folder_id               = module.folders.id["Logging-Monitoring"]
  default_service_account = "disable"
  activate_apis           = []
  labels = {
    terraform_managed = true
  }
}

/*
### google_monitoring_dashboard
Sets up the monitoring dashboards using JSON files.
*/
resource "google_monitoring_dashboard" "main" {
  for_each       = fileset(path.module, "dashboards/*.json") #local.json_file
  project        = module.monitoring.project_id
  dashboard_json = file(each.key)
}

/*
### google_monitoring_monitored_project
Attaches a metrics scope and project ID for monitoring.
Add this to projects that need to be monitored ###
*/
# resource "google_monitoring_monitored_project" "main" {
#   metrics_scope = "change-to-existing-metrics-scope-project"
#   name          = "logging-monitoring-3953"
# }

/*
### storage_destination
Configures a Google Cloud Storage bucket to store exported logs.
*/
module "storage_destination" {
  source                      = "terraform-google-modules/log-export/google//modules/storage"
  version                     = "7.6.0"
  project_id                  = module.monitoring.project_id
  storage_bucket_name         = "${var.owner}-org-logs-${random_string.suffix.result}"
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

/*
### log_export_to_storage
Exports logs to the previously created storage bucket.
*/
module "log_export_to_storage" {
  source                 = "terraform-google-modules/log-export/google"
  version                = "7.6.0"
  destination_uri        = module.storage_destination.destination_uri
  filter                 = local.main_logs_filter
  log_sink_name          = "${var.owner}-log-sink"
  parent_resource_id     = var.org_id
  parent_resource_type   = "organization"
  include_children       = true
  unique_writer_identity = true
}

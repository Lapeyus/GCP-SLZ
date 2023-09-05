/**
### Billing Project Module

This module is responsible for creating a GCP project specifically for billing purposes using the Terraform Google Project Factory module.
- `source`: The source for the Terraform Google Project Factory module. Set to "terraform-google-modules/project-factory/google".
- `version`: Specifies the version of the Google Project Factory module. Currently set to "14.2.0".
- `name`: The name of the billing project. In this case, it is "owner-cor-billing".
- `random_project_id`: If set to `true`, a random project ID is generated.
- `random_project_id_length`: The length of the generated random project ID. Set to 3.
- `org_id`: The GCP Organization ID, sourced from a variable.
- `folder_id`: The ID of the GCP Folder where the project is placed. Sourced from `module.folders.id["Billing"]`.
- `billing_account`: The GCP Billing Account ID, sourced from a variable.
- `budget_amount`: The budget amount for the project, set to "1000".
- `default_service_account`: Default service account settings. Set to "disable" to disable the default service account.
- `activate_apis`: APIs to activate in the project. Sourced from `var.activate_apis["Billing"]`.
*/
module "billing_project" {
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.2.0"
  name                     = "owner-cor-billing"
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  folder_id                = module.folders.id["Billing"]
  billing_account          = var.billing_account
  budget_amount            = "1000"
  default_service_account  = "disable"

  activate_apis = var.activate_apis["Billing"]
  labels = {
    "env" : "prod"
  }
}

/**
### Google Pub/Sub Topic forProduction Budget
Creates a Google Pub/Sub topic forproduction budget alerts.
- `name`: The name of the Pub/Sub topic.
- `project`: The ID of the project where the Pub/Sub topic will be created.
*/

resource "google_pubsub_topic" "prod_budget" {
  name    = "owner-prod-budget-topic-${random_string.suffix.result}"
  project = module.billing_project.project_id
}

/**
### Budget Module for Production Projects

This module is responsible for setting up budgets for production projects.

- `source`: The source for the Terraform Google Budget module.
- `version`: Specifies the version of the Google Budget module.
- `billing_account`: Billing account that will be associated with the project.
- `projects`: List of project IDs that will have this budget.
- `amount`: The amount for the budget.
- `display_name`: The display name of the budget.
- `alert_spent_percents`: Percentages at which alerts will be triggered.
- `credit_types_treatment`: How to treat credit types.
- `alert_pubsub_topic`: Pub/Sub topic where alerts will be sent.
*/
module "budget_prod_projects" {
  source                 = "terraform-google-modules/project-factory/google//modules/budget"
  version                = "14.3.0"
  billing_account        = var.billing_account
  projects               = [module.billing_project.project_id]
  amount                 = "1000"
  display_name           = "Budget for ${module.billing_project.project_id}"
  alert_spent_percents   = [0.5, 0.7, 1.0]
  credit_types_treatment = "INCLUDE_ALL_CREDITS"
  alert_pubsub_topic     = "projects/${module.billing_project.project_id}/topics/${google_pubsub_topic.prod_budget.name}"
  labels = {
    "env" : "prod"
  }
}

/**
### Google Pub/Sub Topic for Pre-Production Budget
Creates a Google Pub/Sub topic for pre-production budget alerts.

- `name`: The name of the Pub/Sub topic.
- `project`: The ID of the project where the Pub/Sub topic will be created.
*/
resource "google_pubsub_topic" "preprod_budget" {
  name    = "owner-preprod-budget-topic-${random_string.suffix.result}"
  project = module.billing_project.project_id
}

/**
### Budget Module for Pre-Production Projects
This module is responsible for setting up budgets for pre-production projects.

- `source`: The source for the Terraform Google Budget module.
- `version`: Specifies the version of the Google Budget module.
- `billing_account`: Billing account that will be associated with the project.
- `projects`: List of project IDs that will have this budget.
- `amount`: The amount for the budget.
- `display_name`: The display name of the budget.
- `alert_spent_percents`: Percentages at which alerts will be triggered.
- `credit_types_treatment`: How to treat credit types.
- `alert_pubsub_topic`: Pub/Sub topic where alerts will be sent.

*/
module "budget_preprod_projects" {
  source                 = "terraform-google-modules/project-factory/google//modules/budget"
  version                = "14.3.0"
  billing_account        = var.billing_account
  projects               = [module.billing_project.project_id]
  amount                 = "1000"
  display_name           = "Budget for ${module.billing_project.project_id}"
  alert_spent_percents   = [0.5, 0.7, 1.0]
  credit_types_treatment = "INCLUDE_ALL_CREDITS"
  alert_pubsub_topic     = "projects/${module.billing_project.project_id}/topics/${google_pubsub_topic.preprod_budget.name}"
  labels = {
    "env" : "prod"
  }
}

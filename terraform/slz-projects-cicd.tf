/*
### CICD Project Module

This module is responsible for creating a GCP project specifically for Continuous Integration and Continuous Deployment (CI/CD) using the Terraform Google Project Factory module.

- `source`: The source for the Terraform Google Project Factory module. Set to "terraform-google-modules/project-factory/google".
- `version`: Specifies the version of the Google Project Factory module. Currently set to "14.2.0".
- `name`: The name of the CI/CD project. In this case, it's "owner-cicd".
- `random_project_id`: If set to `true`, a random project ID is generated.
- `random_project_id_length`: The length of the generated random project ID. Set to 3.
- `org_id`: The GCP Organization ID, sourced from a variable.
- `billing_account`: The GCP Billing Account ID, sourced from a variable.
- `folder_id`: The ID of the GCP Folder where the project is placed. Sourced from `module.folders.id["Shared"]`.
- `svpc_host_project_id`: The project ID for the Shared VPC Host Project. Sourced from `module.shared_vpc_host_project.project_id`.
- `activate_apis`: APIs to activate in the project. Sourced from `var.activate_apis["CICD"]`.
- `terraform_managed`: A boolean indicating that Terraform manages this resource. Set to `true`.
*/
module "cicd" {
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.2.0"
  name                     = "owner-cicd"
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  billing_account          = var.billing_account
  folder_id                = module.folders.id["Shared"]
  svpc_host_project_id     = module.shared_vpc_host_project.project_id
  activate_apis            = var.activate_apis["CICD"]
  labels = {
    terraform_managed = true
  }
}

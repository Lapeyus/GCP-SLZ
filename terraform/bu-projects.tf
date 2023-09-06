/*
The code is creating three local variables, each containing a map of folder IDs from different modules
(`projecta_folders`, `projectb_folders`, `projectc_folders`),
excluding the folders whose keys match with the owner's project
(i.e., `"${var.owner}-projecta"`, `"${var.owner}-projectb"`, and `"${var.owner}-projectc"`).
Only the child folders represent projects, the parent is just a unit for IAM
*/
locals {
  filtered_projecta_folders = { for k, v in module.projecta_folders.id : k => v if k != "${var.owner}-projecta" }
  filtered_projectb_folders = { for k, v in module.projectb_folders.id : k => v if k != "${var.owner}-projectb" }
  filtered_projectc_folders = { for k, v in module.projectc_folders.id : k => v if k != "${var.owner}-projectc" }
}

/*
### Bussines Unit Projects: Project A
The code is creating a Terraform module named "owner_projecta" for each entry in `local.filtered_projecta_folders`,
using the Google Project Factory module, with a random project ID of length 3, specific organization and billing account IDs,
folder ID from the filtered list, host project ID from a shared VPC host project module,
activation of certain APIs, and a label for billing purposes
*/
module "owner_projecta" {
  for_each                 = local.filtered_projecta_folders
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.3.0"
  name                     = each.key
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  billing_account          = var.billing_account
  folder_id                = each.value
  svpc_host_project_id     = module.network.project_id
  activate_apis            = var.activate_apis["projecta"]
  labels = {
    env = "prod"
  }
}

/*
### Bussines Unit Projects: Project B
The code is creating a Terraform module named "owner_projecta" for each entry in `local.filtered_projecta_folders`,
using the Google Project Factory module, with a random project ID of length 3, specific organization and billing account IDs,
folder ID from the filtered list, host project ID from a shared VPC host project module,
activation of certain APIs, and a label for billing purposes
*/
module "projectb" {
  for_each                 = local.filtered_projectb_folders
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.3.0"
  name                     = each.key
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  billing_account          = var.billing_account
  folder_id                = each.value
  svpc_host_project_id     = module.network.project_id
  activate_apis            = var.activate_apis["projectb"]
  labels = {
    env = "prod"
  }
}

/*
### Bussines Unit Projects: Project C
The code is creating a Terraform module named "owner_projecta" for each entry in `local.filtered_projecta_folders`,
using the Google Project Factory module, with a random project ID of length 3, specific organization and billing account IDs,
folder ID from the filtered list, host project ID from a shared VPC host project module,
activation of certain APIs, and a label for billing purposes
*/
module "owner_projectc" {
  for_each                 = local.filtered_projectc_folders
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.3.0"
  name                     = each.key
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  billing_account          = var.billing_account
  folder_id                = each.value
  svpc_host_project_id     = module.network.project_id
  activate_apis            = var.activate_apis["projectc"]
  labels = {
    env = "prod"
  }
}

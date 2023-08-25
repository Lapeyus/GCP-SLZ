locals {
  filtered_projecta_folders  = { for k, v in module.projecta_folders.id : k => v if k != "owner-projecta" }
  filtered_projectbated_folders = { for k, v in module.projectbated_folders.id : k => v if k != "owner-projectb" }
  filtered_projectc_folders   = { for k, v in module.projectc_folders.id : k => v if k != "owner-projectc" }
}

module "owner_projecta_projects" {
  for_each                 = local.filtered_projecta_folders
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.2.0"
  name                     = each.key
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  billing_account          = var.billing_account
  folder_id                = each.value
  svpc_host_project_id     = module.shared_vpc_host_project.project_id
  activate_apis            = var.activate_apis["owner-projecta"]
  labels = {
    terraform_managed = true
  }
}

module "owner_projectbated_projects" {
  for_each                 = local.filtered_projectbated_folders
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.2.0"
  name                     = each.key
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  billing_account          = var.billing_account
  folder_id                = each.value
  svpc_host_project_id     = module.shared_vpc_host_project.project_id
  activate_apis            = var.activate_apis["owner-projectb"]
  labels = {
    terraform_managed = true
  }
}

module "owner_projectc_projects" {
  for_each                 = local.filtered_projectc_folders
  source                   = "terraform-google-modules/project-factory/google"
  version                  = "14.2.0"
  name                     = each.key
  random_project_id        = true
  random_project_id_length = 3
  org_id                   = var.org_id
  billing_account          = var.billing_account
  folder_id                = each.value
  svpc_host_project_id     = module.shared_vpc_host_project.project_id
  activate_apis            = var.activate_apis["owner-projectc"]
  labels = {
    terraform_managed = true
  }
}

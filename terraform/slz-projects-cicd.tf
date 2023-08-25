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

/* ---------------------  Terraform Seed state files -------------------- */
module "tf_state" {
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "~> 4.0"
  name                     = "owner-tf-seed-state"
  project_id               = module.org_seed_project.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "group:gcp-organization-admins@ownerpower.com"
    },
  ]
}

/* ---------------------  Terraform cicd state files -------------------- */
module "cicd_tf_state" {
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "~> 4.0"
  name                     = "owner-tf-cicd-proj-state"
  project_id               = module.org_seed_project.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "group:gcp-organization-admins@ownerpower.com"
    },
  ]
}

/* ---------------------  Projects: Terraform state files -------------------- */
locals {
  filtered_projecta_buckets  = { for k, v in module.projecta_folders.id : k => v if k != "owner-projecta" }
  filtered_curated_buckets = { for k, v in module.curated_folders.id : k => v if k != "owner-Cur" }
  filtered_trans_buckets   = { for k, v in module.trans_folders.id : k => v if k != "owner-Trans" }
}

module "owner_projecta_projects_tf_state" {
  for_each                 = local.filtered_projecta_buckets
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "~> 4.0"
  name                     = each.key
  project_id               = module.org_seed_project.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${google_service_account.service_account.email}"
    },
  ]
}

module "owner_curated_projects_tf_state" {
  for_each                 = local.filtered_curated_buckets
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "~> 4.0"
  name                     = each.key
  project_id               = module.org_seed_project.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${google_service_account.service_account.email}"
    },
  ]
}

module "owner_trans_projects_tf_state" {
  for_each                 = local.filtered_trans_buckets
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "~> 4.0"
  name                     = each.key
  project_id               = module.org_seed_project.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${google_service_account.service_account.email}"
    },
  ]
}

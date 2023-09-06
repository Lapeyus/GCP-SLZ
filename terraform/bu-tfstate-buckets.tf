/*
The code is creating a Terraform module named "tf_state" using the Google Cloud Storage simple bucket module,
with a specified name, project ID from the `seed` module, location set to 'us-east1',
enforced public access prevention, and an IAM policy granting 'storage.objectViewer' role to the group 'gcp-organization-admins@${var.owner}.com'.

This Bucket holds the SLZ terraform state
*/
module "tf_state" {
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "4.0.1"
  name                     = "${var.owner}-tf-seed-state"
  project_id               = module.seed.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "group:gcp-organization-admins@${var.owner}.com"
    },
  ]
}

/*
The code is creating a Terraform module named "tf_state" using the Google Cloud Storage simple bucket module,
with a specified name, project ID from the `seed` module, location set to 'us-east1',
enforced public access prevention, and an IAM policy granting 'storage.objectViewer' role to the group 'gcp-organization-admins@${var.owner}.com'.

This Bucket holds the CICD Project terraform state
*/
module "cicd_tf_state" {
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "4.0.1"
  name                     = "${var.owner}-tf-cicd-state"
  project_id               = module.seed.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "group:gcp-organization-admins@${var.owner}.com"
    },
  ]
}

/*
This code is creating local Terraform variables that filter out specific buckets from the `projecta_folders`,
`projectb_folders`, and `projectc_folders` modules based on their keys, excluding those with keys "${var.owner}-projecta",
"${var.owner}-projectb", and "${var.owner}-projectc" respectively.
*/
locals {
  filtered_projecta_buckets = { for k, v in module.projecta_folders.id : k => v if k != "${var.owner}-projecta" }
  filtered_projectb_buckets = { for k, v in module.projectb_folders.id : k => v if k != "${var.owner}-projectb" }
  filtered_projectc_buckets = { for k, v in module.projectc_folders.id : k => v if k != "${var.owner}-projectc" }
}

/*
The code is creating a Terraform module named "tf_state" using the Google Cloud Storage simple bucket module,
with a specified name, project ID from the `seed` module, location set to 'us-east1',
enforced public access prevention, and an IAM policy granting 'storage.objectViewer' role to the group 'gcp-organization-admins@${var.owner}.com'.

This Bucket holds the Project A terraform state
*/
module "projecta_tf_state" {
  for_each                 = local.filtered_projecta_buckets
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "4.0.1"
  name                     = each.key
  project_id               = module.seed.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${google_service_account.main.email}"
    },
  ]
}

/*
The code is creating a Terraform module named "tf_state" using the Google Cloud Storage simple bucket module,
with a specified name, project ID from the `seed` module, location set to 'us-east1',
enforced public access prevention, and an IAM policy granting 'storage.objectViewer' role to the group 'gcp-organization-admins@${var.owner}.com'.

This Bucket holds the Project B terraform state
*/
module "projectb_tf_state" {
  for_each                 = local.filtered_projectb_buckets
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "4.0.1"
  name                     = each.key
  project_id               = module.seed.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${google_service_account.main.email}"
    },
  ]
}

/*
The code is creating a Terraform module named "tf_state" using the Google Cloud Storage simple bucket module,
with a specified name, project ID from the `seed` module, location set to 'us-east1',
enforced public access prevention, and an IAM policy granting 'storage.objectViewer' role to the group 'gcp-organization-admins@${var.owner}.com'.

This Bucket holds the Project C terraform state
*/
module "projectc_tf_state" {
  for_each                 = local.filtered_projectc_buckets
  source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version                  = "4.0.1"
  name                     = each.key
  project_id               = module.seed.project_id
  location                 = "us-east1"
  public_access_prevention = "enforced"
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${google_service_account.main.email}"
    },
  ]
}

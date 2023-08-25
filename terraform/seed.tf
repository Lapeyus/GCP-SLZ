/*
* # GCP Terraform seed
*
* This code provisions the project, services and service account used by Terraform and grants the roles  for that service account to work.
* To use this code, an admin user for GCP needs to login using the CLI or manually applies the code and then migrates the state. after the initial implementation state for the code is in a cloud storage bucket
*
*/
locals {
  activate_apis_all = toset(flatten(values(var.activate_apis)))
}

module "org_seed_project" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "14.2.0"
  random_project_id       = "false"
  default_service_account = "delete"
  create_project_sa       = false
  name                    = "${var.owner}-seed-prj"
  org_id                  = var.org_id
  billing_account         = var.billing_account
  auto_create_network     = false
  activate_apis           = local.activate_apis_all
  labels = {
    terraform_managed = true
  }
}

/* ------------------------------ Create the SA ----------------------------- */
resource "google_service_account" "tf_seed_sa" {
  account_id   = "tf_seed_sa"
  display_name = "Terraform Service Account"
  project      = module.org_seed_project.project_id
}

#  this key it's only used during initial manual bootstrapping
# resource "google_service_account_key" "account_key" {
#   service_account_id = google_service_account.service_account.name
# }

/* --------------------------- Terraform service account Roles -------------------------- */
module "tf_seed_sa_organization_iam_bindings" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  version       = "7.6.0"
  organizations = [var.org_id]
  mode          = "additive"

  bindings = {
    "roles/resourcemanager.organizationAdmin" = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/resourcemanager.projectCreator"    = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/resourcemanager.folderAdmin"       = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/compute.xpnAdmin"                  = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/serviceusage.serviceUsageAdmin"    = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/billing.user"                      = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/iam.serviceAccountAdmin"           = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
  }
}

module "tf_seed_sa_project_iam_bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version  = "7.6.0"
  projects = [module.org_seed_project.project_id]
  mode     = "additive"

  bindings = {
    "roles/serviceusage.serviceUsageAdmin" = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/iam.serviceAccountKeyAdmin"     = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/iam.serviceAccountAdmin"        = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/iam.serviceAccountTokenCreator" = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/iam.workloadIdentityUser"       = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/iam.workloadIdentityPoolAdmin"  = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/storage.objectCreator"          = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/storage.objectViewer"           = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
    "roles/storage.admin"                  = ["serviceAccount:${google_service_account.tf_seed_sa.email}"],
  }
}

/* ------------------- Workload Identity Federation for github actions --------- */
resource "google_iam_workload_identity_pool" "idp_pool" {
  workload_identity_pool_id = "github-terraformer"
  project                   = module.org_seed_project.project_id
}

resource "google_iam_workload_identity_pool_provider" "gh_provider" {
  workload_identity_pool_id          = "github-terraformer"
  workload_identity_pool_provider_id = "gh-actions"
  display_name                       = "gh-actions"
  oidc {
    allowed_audiences = []
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
}

/* --------------------- Apply Workload Identity Binding -------------------- */
resource "google_service_account_iam_binding" "workload_identity_binding" {
  service_account_id = google_service_account.service_account.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    # Workload Identity Federation for github actions
    # one repo at a time
    "principalSet://iam.googleapis.com/projects/734894532576/locations/global/workloadIdentityPools/github-terraformer/attribute.repository/${var.owner}-Power/${var.owner}-slz",
    "principalSet://iam.googleapis.com/projects/734894532576/locations/global/workloadIdentityPools/github-terraformer/attribute.repository/${var.owner}-Power/${var.owner}-shared-infra",
    "principalSet://iam.googleapis.com/projects/734894532576/locations/global/workloadIdentityPools/github-terraformer/attribute.repository/${var.owner}-Power/${var.owner}-projecta-infra",
    "principalSet://iam.googleapis.com/projects/734894532576/locations/global/workloadIdentityPools/github-terraformer/attribute.repository/${var.owner}-Power/${var.owner}-projectc-infra",
    "principalSet://iam.googleapis.com/projects/734894532576/locations/global/workloadIdentityPools/github-terraformer/attribute.repository/${var.owner}-Power/${var.owner}-projectb-infra",

    # uncomment to allow all client repos to impersonate the terraform SA
    # "principalSet://iam.googleapis.com/projects/734894532576/locations/global/workloadIdentityPools/github-terraformer/attribute.repository_${var.owner}/${var.owner}-Power",

    # uncomment to use Use Workload Identity with Google Kubernetes Engine, once for each namespace
    # "serviceAccount:${module.org_seed_project.project_id}.svc.id.goog[${NAMESPACE}/${var.service_account}]",
  ]
}

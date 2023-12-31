/*
### Local Variables
The Seed project needs to have all the APIs defined in var.activate_apis enabled
not only for the project itself but for every child project

- add all APIs
- remove duplicates
*/
locals {
  activated_apis = toset(flatten(values(var.activate_apis)))
}

/*
### Org Seed Project
This Terraform module, `seed`, is used to create a Google Cloud Project with specific configurations using the Project Factory module, without creating a random project ID, a default service account, or a network, activates all agregated APIs.
*/
module "seed" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "14.3.0"
  random_project_id       = "true"
  default_service_account = "delete"
  create_project_sa       = false
  name                    = "${var.owner}-seed"
  org_id                  = var.org_id
  billing_account         = var.billing_account
  auto_create_network     = false
  activate_apis           = local.activated_apis
  labels = {
    terraform_managed = true
  }
}

/*
### Google Service Account
This Terraform code creates a Google Cloud Service Account named `Terraform Service Account` with the account ID `main` in the project created by the `seed` module.
*/
resource "google_service_account" "main" {
  account_id   = "tf-seed"
  display_name = "Terraform Seed Service Account"
  project      = module.seed.project_id
  depends_on   = [module.seed]
}

/*
### Google Service Account Key
This Terraform code generates a new private key for the `main` Google Cloud Service Account and stores it in `google_service_account_key` named `main`.[OPTIONAL][NOT RECOMENDED]
*/
resource "google_service_account_key" "main" {
  service_account_id = google_service_account.main.name
  depends_on         = [google_service_account.main]
}

/*
### Terraform Service Account Org IAM Bindings
1. `"roles/resourcemanager.organizationAdmin"`:
necessary for the service account to manage organization-wide resources effectively.

2. `"roles/resourcemanager.projectCreator"`:
allows the service account to create new projects within the organization.

3. `"roles/resourcemanager.folderAdmin"`:
grants administrative access to manage folders within the organization.

4. `"roles/compute.xpnAdmin"`:
allows the service account to manage network resources across projects.

5. `"roles/serviceusage.serviceUsageAdmin"`:
allows enabling or disabling various Google Cloud services across projects.

6. `"roles/billing.user"`:
allows the service account to view and manage billing information.

7. `"roles/iam.serviceAccountAdmin"`:
grants administrative access to manage service accounts.
*/
module "org_iam_bindings" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  version       = "7.6.0"
  organizations = [var.org_id]
  mode          = "additive"

  bindings = {
    "roles/resourcemanager.organizationAdmin" = ["serviceAccount:${google_service_account.main.email}"],
    "roles/resourcemanager.projectCreator"    = ["serviceAccount:${google_service_account.main.email}"],
    "roles/resourcemanager.folderAdmin"       = ["serviceAccount:${google_service_account.main.email}"],
    "roles/compute.xpnAdmin"                  = ["serviceAccount:${google_service_account.main.email}"],
    "roles/serviceusage.serviceUsageAdmin"    = ["serviceAccount:${google_service_account.main.email}"],
    "roles/billing.user"                      = ["serviceAccount:${google_service_account.main.email}"],
    "roles/iam.serviceAccountAdmin"           = ["serviceAccount:${google_service_account.main.email}"],
  }
  depends_on = [google_service_account.main]
}

/*
### Terraform Service Account Project IAM Bindings

1. `"roles/serviceusage.serviceUsageAdmin"`: for enabling or disabling specific Google Cloud services within the project.

2. `"roles/iam.serviceAccountKeyAdmin"`: manage its own keys.

3. `"roles/iam.serviceAccountAdmin"`: manage other service accounts at the project level.

4. `"roles/iam.serviceAccountTokenCreator"`: create tokens for other service accounts.

5. `"roles/iam.workloadIdentityUser"`: allows the service account to act as a workload identity user.

6. `"roles/iam.workloadIdentityPoolAdmin"`: allows the service account to manage id pools.

7. `"roles/storage.objectCreator"`: Permission to create objects in Cloud Storage.

8. `"roles/storage.objectViewer"`: provides read access to objects in Cloud Storage.

9. `"roles/storage.admin"`: It includes permissions to create, delete, and modify storage buckets and objects.

*/
module "project_iam_bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version  = "7.6.0"
  projects = [module.seed.project_id]
  mode     = "additive"

  bindings = {
    "roles/serviceusage.serviceUsageAdmin" = ["serviceAccount:${google_service_account.main.email}"],
    "roles/iam.serviceAccountKeyAdmin"     = ["serviceAccount:${google_service_account.main.email}"],
    "roles/iam.serviceAccountAdmin"        = ["serviceAccount:${google_service_account.main.email}"],
    "roles/iam.serviceAccountTokenCreator" = ["serviceAccount:${google_service_account.main.email}"],
    "roles/iam.workloadIdentityUser"       = ["serviceAccount:${google_service_account.main.email}"],
    "roles/iam.workloadIdentityPoolAdmin"  = ["serviceAccount:${google_service_account.main.email}"],
    "roles/storage.objectCreator"          = ["serviceAccount:${google_service_account.main.email}"],
    "roles/storage.objectViewer"           = ["serviceAccount:${google_service_account.main.email}"],
    "roles/storage.admin"                  = ["serviceAccount:${google_service_account.main.email}"],
  }
  depends_on = [google_service_account.main]
}

/*
### Identity Pool
This Terraform code creates a new Google Cloud IAM Workload Identity Pool with the ID `cicd-terraformer` in the specified project.
*/
resource "google_iam_workload_identity_pool" "main" {
  workload_identity_pool_id = "cicd-terraformer"
  project                   = module.seed.project_id
  depends_on                = [module.seed]
}

/*
### Google IAM Workload Identity Pool Provider
Identity Pool Provider for the identity pool `google_iam_workload_identity_pool.main`, configures it with an empty list of allowed audiences, an Github issuer URI, and attribute mappings for OIDC (OpenID Connect).
*/
resource "google_iam_workload_identity_pool_provider" "github_actions" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.main.id
  workload_identity_pool_provider_id = "gh-actions"
  display_name                       = "gh-actions"
  attribute_condition                = "repository_owner == '${var.owner}'"
  oidc {
    allowed_audiences = ["//iam.googleapis.com/${google_iam_workload_identity_pool.main.id}"]
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  depends_on = [google_iam_workload_identity_pool.main]
}

/*
### Google Service Account IAM Binding
Member repos can impersonate the terraform SA via github actions.

- Uncomment A to allow all client repos to impersonate the terraform SA (not recommended)
- Uncomment B to use Use Workload Identity with Google Kubernetes Engine, once for each namespace
*/

resource "google_service_account_iam_binding" "workload_identity" {
  service_account_id = google_service_account.main.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.id}/attribute.repository/${var.owner}/owner", #${SLZ-REPO-NAME}

    # A: "principalSet://iam.googleapis.com/projects/${module.seed.project_number}/locations/global/workloadIdentityPools/cicd-terraformer/attribute.repository_owner/${var.owner}",

    # B: "serviceAccount:${module.seed.project_id}.svc.id.goog[${NAMESPACE}/${var.service_account}]",
  ]
  depends_on = [google_service_account.main, google_iam_workload_identity_pool_provider.github_actions]
}

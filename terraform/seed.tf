/* 
### Local Variables
The Seed project needs to have all the APIs defined in var.activate_apis enabled
not only for the project itself but for every child project

- add all APIs
- remove duplicates
*/
locals {
  activate_apis_all = toset(flatten(values(var.activate_apis)))
}

/* 
### Org Seed Project
This Terraform module, `org_seed_project`, is used to create a Google Cloud Project with specific configurations using the Project Factory module, without creating a random project ID, a default service account, or a network, activates all agregated APIs.
*/
module "org_seed_project" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "14.3.0"
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
/* 
### Google Service Account
This Terraform code creates a Google Cloud Service Account named `Terraform Service Account` with the account ID `tf_seed` in the project created by the `org_seed_project` module.
*/
resource "google_service_account" "tf_seed" {
  account_id   = "tf-seed"
  display_name = "Terraform Seed Service Account"
  project      = module.org_seed_project.project_id
  depends_on   = [module.org_seed_project]
}
/* 
## Google Service Account Key [OPTIONAL][NOT RECOMENDED]
This Terraform code generates a new private key for the `tf_seed` Google Cloud Service Account and stores it in `google_service_account_key` named `tf_seed`. 
*/
resource "google_service_account_key" "tf_seed" {
  service_account_id = google_service_account.tf_seed.name
  depends_on         = [google_service_account.tf_seed]
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
module "tf_seed_organization_iam_bindings" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  version       = "7.6.0"
  organizations = [var.org_id]
  mode          = "additive"

  bindings = {
    "roles/resourcemanager.organizationAdmin" = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/resourcemanager.projectCreator"    = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/resourcemanager.folderAdmin"       = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/compute.xpnAdmin"                  = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/serviceusage.serviceUsageAdmin"    = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/billing.user"                      = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/iam.serviceAccountAdmin"           = ["serviceAccount:${google_service_account.tf_seed.email}"],
  }
  depends_on = [google_service_account.tf_seed]
}
/* 
## Terraform Service Account Project IAM Bindings

1. `"roles/serviceusage.serviceUsageAdmin"`: relevant for enabling or disabling specific Google Cloud services within the project.

2. `"roles/iam.serviceAccountKeyAdmin"`: The service account might need to manage its own keys.

3. `"roles/iam.serviceAccountAdmin"`: If the service account needs to manage other service accounts at the project level, is necessary.

4. `"roles/iam.serviceAccountTokenCreator"`: service account needs to create tokens for other service accounts.

5. `"roles/iam.workloadIdentityUser"`: allows the service account to act as a workload identity user.

6. `"roles/iam.workloadIdentityPoolAdmin"`: allows the service account to manage id pools.  

7. `"roles/storage.objectCreator"`: Permission to create objects in Cloud Storage. 

8. `"roles/storage.objectViewer"`: provides read access to objects in Cloud Storage.  

9. `"roles/storage.admin"`: It includes permissions to create, delete, and modify storage buckets and objects.

*/
module "tf_seed_project_iam_bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version  = "7.6.0"
  projects = [module.org_seed_project.project_id]
  mode     = "additive"

  bindings = {
    "roles/serviceusage.serviceUsageAdmin" = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/iam.serviceAccountKeyAdmin"     = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/iam.serviceAccountAdmin"        = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/iam.serviceAccountTokenCreator" = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/iam.workloadIdentityUser"       = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/iam.workloadIdentityPoolAdmin"  = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/storage.objectCreator"          = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/storage.objectViewer"           = ["serviceAccount:${google_service_account.tf_seed.email}"],
    "roles/storage.admin"                  = ["serviceAccount:${google_service_account.tf_seed.email}"],
  }
  depends_on = [google_service_account.tf_seed]
}

/* 
### Identity Pool
This Terraform code creates a new Google Cloud IAM Workload Identity Pool with the ID `cicd-terraformer` in the specified project, and stores it in `google_iam_workload_identity_pool` named `cicd_terraformer`.
*/
resource "google_iam_workload_identity_pool" "cicd_terraformer" {
  workload_identity_pool_id = "cicd-terraformer"
  project                   = module.org_seed_project.project_id
  depends_on                = [module.module.org_seed_project]
}
/* 
### Resource: Google IAM Workload Identity Pool Provider
This Terraform code creates a new Google Cloud IAM Workload Identity Pool Provider for the identity pool `cicd-terraformer`, and configures it with an empty list of allowed audiences, an Github issuer URI, and attribute mappings for OIDC (OpenID Connect).
*/
resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.cicd_terraformer.id
  workload_identity_pool_provider_id = "gh-actions"
  display_name                       = "gh-actions"
  oidc {
    allowed_audiences = []
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  depends_on = [google_iam_workload_identity_pool.cicd_terraformer]
}

/* 
### Google Service Account IAM Binding 
Member repos can impersonate the terraform SA via github actions.

- Uncomment A to allow all client repos to impersonate the terraform SA (not recommended)
- Uncomment B to use Use Workload Identity with Google Kubernetes Engine, once for each namespace
*/

resource "google_service_account_iam_binding" "workload_identity" {
  service_account_id = google_service_account.service_account.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.cicd_terraformer.id}/attribute.repository/${var.owner}/${SLZ-REPO-NAME}",

    # A: "principalSet://iam.googleapis.com/projects/${module.org_seed_project.project_number}/locations/global/workloadIdentityPools/cicd-terraformer/attribute.repository_owner/${var.owner}",

    # B: "serviceAccount:${module.org_seed_project.project_id}.svc.id.goog[${NAMESPACE}/${var.service_account}]",
  ]
  depends_on = [google_iam_workload_identity_pool.cicd_terraformer]
}

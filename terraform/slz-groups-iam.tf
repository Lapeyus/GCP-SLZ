module "gcp-admins" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  version       = "7.6.0"
  organizations = [var.org_id]
  mode          = "additive"

  bindings = {
    "roles/resourcemanager.organizationAdmin" = [
      "group:${module.gcp_admins.id}",
    ]
    "roles/iam.securityAdmin" = [
      "group:${module.gcp_admins.id}",
    ]
    "roles/billing.admin" = [
      "group:${module.gcp_admins.id}",
    ]
  }
}

module "security-admins" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "7.6.0"
  folders = [module.folders.id["Security"]]
  mode    = "additive"

  bindings = {
    "roles/iam.securityAdmin" = [
      "group:${module.security_admins.id}",
    ]
  }
}

module "network-admins" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "7.6.0"
  folders = [module.folders.id["Network"]]
  mode    = "additive"

  bindings = {
    "roles/compute.networkAdmin" = [
      "group:${module.network_admins.id}",
    ]
    "roles/vpcaccess.admin" = [
      "group:${module.security_admins.id}",
    ]
  }
}

module "audit-admins" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "7.6.0"
  folders = [module.folders.id["Logging-Monitoring"]]
  mode    = "additive"

  bindings = {
    "roles/iam.securityReviewer" = [
      "group:${module.audit_admins.id}",
    ],
    "roles/logging.viewer" = [
      "group:${module.audit_admins.id}",
    ]
  }
}

module "project-admins" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "7.6.0"
  folders = [module.folders.id["owner"], module.folders.id["Shared"]]
  mode    = "additive"

  bindings = {
    "roles/editor" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ]
    "roles/iam.serviceAccountAdmin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ]
    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ]
    "roles/artifactregistry.admin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ]
    "roles/artifactregistry.repoAdmin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ]
  }
}

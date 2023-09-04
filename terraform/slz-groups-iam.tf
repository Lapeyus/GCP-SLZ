/*
### GCP Admins
- **roles/resourcemanager.organizationAdmin**: grants full control over all resources in the Google Cloud organization. can manage IAM policies, create and delete projects, and have all permissions of all roles.

- **roles/iam.securityAdmin**: Manage access control for all resources that reside within an organization, and to view security configuration information. It includes most IAM permissions like managing service accounts and keys

- **roles/orgpolicy.policyAdmin**: This role grants permissions to view, create, update and delete organization policies. It allows the user to set constraints across the entire organization, enforcing consistent rules and standards.

- **roles/billing.admin**: This role allows users to manage all aspects of billing for the Google Cloud organization. This includes setting up billing accounts, linking them to projects, viewing billing history and reports, and managing payment methods.
*/
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
    "roles/orgpolicy.policyAdmin" = [
      "group:${module.gcp_admins.id}",
    ]
    "roles/billing.admin" = [
      "group:${module.gcp_admins.id}",
    ]
  }
}

/*
### Security Admins
- **roles/iam.securityAdmin**: Manage access control for all resources that reside within an organization, and to view security configuration information. It includes most IAM permissions like managing service accounts and keys

- **roles/orgpolicy.policyAdmin**: This role grants permissions to view, create, update and delete organization policies. It allows the user to set constraints across the entire organization, enforcing 

- **roles/iam.serviceAccountAdmin**: This role allows management of service accounts.

- **roles/resourcemanager.folderAdmin**: This role allows full control of folders.

- **roles/logging.configWriter**: This role allows writing of all logging configurations.

- **roles/compute.securityAdmin**: This role provides access to view, modify, and create security settings.
 
*/
module "security-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "7.6.0"
  # folders = [module.folders.id["Security"]]
  mode = "additive"

  bindings = {
    "roles/iam.securityAdmin" = [
      "group:${module.security_admins.id}",
    ]
    "roles/orgpolicy.policyAdmin" = [
      "group:${module.security_admins.id}",
    ]
    "roles/iam.serviceAccountAdmin" = [
      "group:${module.security_admins.id}",
    ]
    "roles/resourcemanager.folderAdmin" = [
      "group:${module.security_admins.id}",
    ]
    "roles/logging.configWriter" = [
      "group:${module.security_admins.id}",
    ]
    "roles/compute.securityAdmin" = [
      "group:${module.security_admins.id}",
    ]
  }
}

/*
### Network Admins
- **roles/compute.networkAdmin**: This role allows a user to administer Compute Engine networks. It includes permissions to create, modify, and delete networking resources such as subnets, routers, firewalls, etc.

- **roles/vpcaccess.admin**: This role grants permissions to manage VPC Access Connectors. These connectors are used to connect Google Cloud services with VPC networks.

- **roles/dns.admin**: This role allows full control over Cloud DNS resources, which could be useful if your network admins need to manage DNS records.

- **roles/compute.loadBalancerAdmin**: This role provides access to create, modify, and delete load balancing resources.

- **roles/compute.securityAdmin**: This role provides access to view, modify, and create security settings related to Compute Engine.
*/
module "network-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "7.6.0"
  # folders = [module.folders.id["Network"]]
  mode = "additive"

  bindings = {
    "roles/compute.networkAdmin" = [
      "group:${module.network_admins.id}",
    ]
    "roles/vpcaccess.admin" = [
      "group:${module.network_admins.id}",
    ]
    "roles/dns.admin" = [
      "group:${module.network_admins.id}",
    ]
    "roles/compute.loadBalancerAdmin" = [
      "group:${module.network_admins.id}",
    ]
    "roles/compute.securityAdmin" = [
      "group:${module.network_admins.id}",
    ]
  }
}
/*
### Audit Admins
- **roles/iam.securityReviewer**: This role allows a user to view IAM settings and policies across the Google Cloud environment.

- **roles/logging.viewer**: This role allows a user to view logs that are stored in the Logging section of the Google Cloud Console.

- **roles/audit.configViewer**: This role provides read-only access to view all configuration and settings for services.

- **roles/errorreporting.viewer**: This role grants permissions to view error reporting data.

- **roles/serviceusage.serviceUsageConsumer**: This role allows viewing service usage and configurations.
*/
module "audit-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "7.6.0"
  # folders = [module.folders.id["Logging-Monitoring"]]
  mode = "additive"

  bindings = {
    "roles/iam.securityReviewer" = [
      "group:${module.audit_admins.id}",
    ],
    "roles/logging.viewer" = [
      "group:${module.audit_admins.id}",
    ],
    "roles/audit.configViewer" = [
      "group:${module.audit_admins.id}",
    ],
    "roles/errorreporting.viewer" = [
      "group:${module.audit_admins.id}",
    ],
    "roles/serviceusage.serviceUsageConsumer" = [
      "group:${module.audit_admins.id}",
    ]
  }
}
/*
### Project Admins

- **roles/editor**: This role has permissions to access all resources, and can perform all actions except for a few like changing IAM settings.

- **roles/iam.serviceAccountAdmin**: This role allows users to administer service accounts.

- **roles/iam.serviceAccountTokenCreator**: This role allows users to create OAuth2 access tokens, sign blobs or JWTs and sign JWTs for service accounts.

- **roles/artifactregistry.admin**: This role grants full control over artifacts and settings in Artifact Registry.

- **roles/artifactregistry.repoAdmin**: This role grants full control over repositories in Artifact Registry.

- **roles/resourcemanager.projectIamAdmin**: This role grants full control over IAM policies within a project.

- **roles/storage.admin**: This role grants full control of objects and buckets in Google Cloud Storage.

- **roles/compute.admin**: This role provides full control over compute resources.

*/
module "project-admins" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "7.6.0"
  folders = [module.folders.id["BussinesUnits"], module.folders.id["Shared"]]
  mode    = "additive"

  bindings = {
    "roles/editor" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ],
    "roles/iam.serviceAccountAdmin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ],
    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ],
    "roles/artifactregistry.admin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ],
    "roles/artifactregistry.repoAdmin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ],
    "roles/resourcemanager.projectIamAdmin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ],
    "roles/storage.admin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ],
    "roles/compute.admin" = [
      "serviceAccount:${google_service_account.service_account.email}",
      "group:${module.project_admins.id}",
    ]
  }
}

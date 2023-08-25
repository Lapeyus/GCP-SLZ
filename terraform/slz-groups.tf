# In order to mantain this implementation as an effective and secure landing zone on GCP,
# you should consider the principle of least privilege,
# where you should grant only the necessary access to users, groups and services to perform their tasks.

# 1. **GCP Admins**: members of this group will have broad permissions across the entire org.
# The number of members on this group should be limited.
module "gcp_admins" {
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "admins@${data.google_organization.org.domain}"
  display_name = "GCP Admins"
  description  = "Group for GCP Administrators"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = ["joseph.villarreal@66degrees.com"]
  owners       = []
}

# 2. **Security Admins**: members of this group will have permissions related to security settings,
# like configuring Identity and Access Management (IAM), organization policies, etc.
module "security_admins" {
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "security-admins@${data.google_organization.org.domain}"
  display_name = "GCP Security Admins"
  description  = "Group for GCP Security Administrators"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = []
  owners       = []
}

# 3. **Network Admins**: This group is responsible for the management of network resources such as VPCs,
# subnets, firewall rules, etc.
module "network_admins" {
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "network-admins@${data.google_organization.org.domain}"
  display_name = "GCP Network Admins"
  description  = "Group for GCP Network Administrators"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = ["joseph.villarreal@66degrees.com"]
  owners       = []
}

# 4. **Audit Admins**: members of this group will have permissions to view all resources and settings,
# meant for auditing and compliance purposes.
module "audit_admins" {
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "audit-admins@${data.google_organization.org.domain}"
  display_name = "GCP Audit Admins"
  description  = "Group for GCP Audit Administrators"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = []
  owners       = []
}

# 5. **Project Admins**: This is a global grant to manage all projects in the ORG.
# we have dedicated groups to manage each project individually. see alt-groups.tf
module "project_admins" {
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "project-admins@${data.google_organization.org.domain}"
  display_name = "GCP Project Admins"
  description  = "Group for GCP Project Administrators"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = []
  owners       = []
}

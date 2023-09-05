/*
### Skip Default Network Creation
Prevents the automatic creation of a default network in new projects.
*/
module "skip_default_network" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.skipDefaultNetworkCreation"
  policy_type = "boolean"
}
/*
### Uniform Bucket Level Access
Enforces uniform bucket-level access control across all Cloud Storage buckets.
*/
module "uniform_bucket_level_access" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/storage.uniformBucketLevelAccess"
  policy_type = "boolean"
}

/*
### Enforce Bucket Public Access Prevention
Prevents public access to Cloud Storage buckets.
*/
module "enforce_bucket_public_access_prevention" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/storage.publicAccessPrevention"
  policy_type = "boolean"
}

/*
### Disable VM Serial Ports
Disables the global serial port access to VM instances.
*/
module "disable_vm_serial_ports" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.disableGlobalSerialPortAccess"
  policy_type = "boolean"
}

/*
### Restrict Shared VPC Project Lien
Restricts the removal of shared VPC project liens.
*/
module "restrict_shared_vpc_project_lien" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = false
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.restrictXpnProjectLienRemoval"
  policy_type = "boolean"
}

/*
### Restrict Public IP CloudSQL
Disallows public IP addresses for Cloud SQL instances.
*/
module "restrict_public_ip_cloudsql" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/sql.restrictPublicIp"
  policy_type = "boolean"
}

/*
### Disable VM Nested Virtualization
Prevents the use of nested virtualization in VM instances.
*/
module "disable_vm_nested_virtualization" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.disableNestedVirtualization"
  policy_type = "boolean"
}

/*
### Disable Guest Attributes Access
Blocks access to guest attributes in VM instances.
*/
module "disable_guest_attributes" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.disableGuestAttributesAccess"
  policy_type = "boolean"
}

/*
### Require OS Login
Enforces OS login for SSH access to VM instances.
*/
module "require_os_login" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.requireOsLogin"
  policy_type = "boolean"
}

/*
### Domain Restricted Sharing
Restricts sharing to specific domains.
*/
module "domain_restricted_sharing" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = false
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/iam.allowedPolicyMemberDomains"
  policy_type = "list"
}

/*
### Restrict VM External IP
Prohibits external IP access for VM instances.
*/
module "restrict_vm_external_ip" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.vmExternalIpAccess"
  policy_type = "list"
}

/*
### Restrict VPC Peering
Limits VPC peering connections.
*/
module "restrict_vpc_peering" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = false
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.restrictVpcPeering"
  policy_type = "list"
}

/*
### Restrict Shared VPC Host Projects
Restricts the creation of shared VPC host projects.
*/
module "restrict_vpc_host_projects" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = false
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/compute.restrictSharedVpcHostProjects"
  policy_type = "list"
}

/*
### Disable Service Account Key Creation
Prevents the creation of service account keys.
*/
module "disable_service_account_key_creation" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/iam.disableServiceAccountKeyCreation"
  policy_type = "boolean"
}

/*
### Disable Service Account Key Upload
Disallows the upload of service account keys.
*/
module "disable_service_account_key_upload" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/iam.disableServiceAccountKeyUpload"
  policy_type = "boolean"
}

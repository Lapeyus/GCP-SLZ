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

module "folders" {
  source = "../modules/google_folder"

  folders = {
    "Core"               = { external_parent_id = "organizations/${var.org_id}" },
    "Billing"            = { parent_entry_key = "Core" },
    "Logging-Monitoring" = { parent_entry_key = "Core" },
    "Security"           = { parent_entry_key = "Core" },
    "Network"            = { parent_entry_key = "Core" },
    "Shared"             = { external_parent_id = "organizations/${var.org_id}" },
    "Shared-Prod"        = { parent_entry_key = "Shared" },
    "Shared-NonProd"     = { parent_entry_key = "Shared" },
    "BussinesUnits" = {
      name               = "BussinesUnits"
      external_parent_id = "organizations/${var.org_id}"
    },
  }
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}

/*
### Folder Structure
- **Organizations**: The root level, representing your organization on Google Cloud Platform.
- **Core**: A foundational folder for critical organizational resources. subfolders:
  - **Billing**: Managing billing accounts and related information.
  - **Logging-Monitoring**: Segregating logging and monitoring resources.
  - **Security**: Holds security-related configurations and policies.
  - **Network**: For managing network-related resources.
- **Shared**: A folder hosting shared resources with subfolders for production and non-production environments.
- **BussinesUnits**: Businnes Unit attachment point. this folder is used to nest all Bussines Units that company has, a Bussines Unit holds project folders, a project has environment folders. see bu-folders.tf.
*/
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

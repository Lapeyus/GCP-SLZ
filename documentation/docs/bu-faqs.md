# Managing Business Units in GCP with Terraform 🛠️☁️

These snippets together form a comprehensive Terraform code to manage different aspects of Business Unit projects, folders, and groups, all within the Google Cloud Platform. 

!!! note "Customization Required"
    Make sure to customize the code according to your specific requirements and organizational structure.

---

### Adding New Project Folders to a Business Unit 📁

You can create new project folders for a Business Unit by defining Terraform modules like `projecta_folders`, `projectbated_folders`, and `projectc_folders`.

```hcl
    module "projecta_folders" {
      source = "../modules/google_folder"

      folders = {
        "BU-projecta" = { external_parent_id = module.folders.id["Business Unit"] },

      }
    }
```

---

### Adding New Projects to a Business Unit 📋

You can add new projects to a Business Unit by defining Terraform modules like `BU_projecta_projects`, `BU_projectb_projects`, and `BU_projectc_projects`.

```hcl
    module "BU_projecta_projects" {
      for_each                 = local.filtered_projecta_folders
      source                   = "terraform-google-modules/project-factory/google"
    }
```

---

### Adding New Project State Buckets to a Business Unit 🪣

You can create state buckets for BU projects using modules like `BU_projecta_projects_tf_state`, `BU_projectbated_projects_tf_state`, and `BU_projectc_projects_tf_state`.

```hcl
    module "BU_projecta_projects_tf_state" {
      for_each                 = local.filtered_projecta_buckets
      source                   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
    }
```

---

### Adding New Project Groups to a Business Unit 👥

You can create project groups in BU by defining the `project_groups` module and combining folders and group types.

```hcl
    module "project_groups" {
      for_each     = { for combination in local.folder_group_combinations : "${combination.display_name}-${combination.group_type}" => combination }
      source       = "terraform-google-modules/group/google"
    }
```


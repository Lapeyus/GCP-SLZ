data "google_folders" "prj_folders" {
  parent_id = module.folders.id["owner"]
}

locals {
  child_folders = [for folder in data.google_folders.prj_folders.folders : folder]
  groups        = ["developers", "devops", "admins"]
  folder_group_combinations = flatten([
    for folder in local.child_folders : [
      for group in local.groups : {
        display_name = lower(folder.display_name),
        group_type   = group
      }
    ]
  ])
  members = {
    owner-projecta-developers = []
    owner-projecta-devops     = []
    owner-projecta-admins     = []
    owner-projectb-developers    = []
    owner-projectb-devops        = []
    owner-projectb-admins        = []
    owner-projectc-developers  = []
    owner-projectc-devops      = []
    owner-projectc-admins      = []
  }

}

module "project_groups" {
  for_each     = { for combination in local.folder_group_combinations : "${combination.display_name}-${combination.group_type}" => combination }
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "${each.value.display_name}-${each.value.group_type}@${data.google_organization.org.domain}"
  display_name = "${each.value.display_name}-${each.value.group_type}"
  description  = "Group for ${each.value.display_name} ${each.value.group_type}"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = local.members["${each.value.display_name}-${each.value.group_type}"]
  owners       = []
}

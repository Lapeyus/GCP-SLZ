locals {
  iam_bindings = flatten([
    for folder_name, folder in var.folders : can([for role, members in folder.iam : { role = role, members = members }]) ? [
      for role, members in folder.iam : [
        for member in members : {
          folder_name = folder_name
          role        = role
          member      = member
        }
      ]
    ] : []
  ])

  folder_id = { for key, folder in merge(
    google_folder.layer1_folders,
    google_folder.layer2_folders,
    google_folder.layer3_folders,
    google_folder.layer4_folders,
    google_folder.layer5_folders,
    google_folder.layer6_folders,
    google_folder.layer7_folders,
    google_folder.layer8_folders,
    google_folder.layer9_folders,
    google_folder.layer10_folders) : key => folder.name
  }
}

data "google_iam_policy" "folder_iam_policy" {
  for_each = { for name, folder in var.folders : name => folder if try(folder.iam_mode, "additive") == "authoritative" }

  dynamic "audit_config" {
    for_each = each.value.audit_logs != null && each.value.audit_logs != {} ? each.value.audit_logs : {}

    content {
      service = try(audit_config.value.service, "allServices")

      dynamic "audit_log_configs" {
        for_each = try([audit_config.value.log_type], ["DATA_READ"])
        content {
          log_type         = audit_log_configs.value
          exempted_members = try(audit_config.value.exempted_members, [])
        }
      }
    }
  }

  dynamic "binding" {
    for_each = can([for role, members in each.value.iam : { role = role, members = members }]) ? each.value.iam : {}

    content {
      role    = binding.key
      members = binding.value
    }
  }

  depends_on = [google_folder.layer1_folders, google_folder.layer2_folders, google_folder.layer3_folders, google_folder.layer4_folders, google_folder.layer5_folders, google_folder.layer6_folders, google_folder.layer7_folders, google_folder.layer8_folders, google_folder.layer9_folders, google_folder.layer10_folders]
}

resource "google_folder_iam_policy" "folder_admin_policy" {
  for_each = { for name, folder in var.folders : name => folder if try(folder.iam_mode, "additive") == "authoritative" }

  folder      = local.folder_id[each.key]
  policy_data = data.google_iam_policy.folder_iam_policy[each.key].policy_data
  depends_on  = [google_folder.layer1_folders, google_folder.layer2_folders, google_folder.layer3_folders, google_folder.layer4_folders, google_folder.layer5_folders, google_folder.layer6_folders, google_folder.layer7_folders, google_folder.layer8_folders, google_folder.layer9_folders, google_folder.layer10_folders, data.google_iam_policy.folder_iam_policy]
}

resource "google_folder_iam_member" "folder_iam_member" {
  for_each = { for binding in local.iam_bindings : "${binding.folder_name}-${binding.role}-${binding.member}" => binding if try(var.folders[binding.folder_name].iam_mode, "additive") == "additive" }

  folder = local.folder_id[each.value.folder_name]
  role   = each.value.role
  member = each.value.member
}

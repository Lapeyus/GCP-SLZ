locals {
  folders_with_audit_logs = {
    for folder_key, folder in var.folders :
    folder_key => folder.iam_mode == "additive" ? {
      audit_logs = folder.audit_logs != null ? [
        for audit_log_key, audit_log in folder.audit_logs :
        {
          service          = audit_log.service
          log_type         = audit_log.log_type
          exempted_members = audit_log.exempted_members
        } if audit_log.service != null && audit_log.log_type != null
      ] : []
    } : null
  }

  flat_audit_configs = flatten([
    for folder_key, folder in local.folders_with_audit_logs : folder != null ? [
      for audit_log_key, audit_log in folder.audit_logs : {
        folder_key       = folder_key
        audit_log_key    = audit_log_key
        service          = audit_log.service
        log_type         = audit_log.log_type
        exempted_members = audit_log.exempted_members
      }
    ] : []
  ])
}

resource "google_folder_iam_audit_config" "folder_iam_audit_config" {
  for_each = { for item in local.flat_audit_configs : "${item.folder_key}.${item.audit_log_key}" => item }

  folder  = local.folder_id[each.value.folder_key]
  service = each.value.service

  dynamic "audit_log_config" {
    for_each = [for log_config in local.flat_audit_configs : log_config if log_config.service == each.value.service]

    content {
      log_type         = audit_log_config.value.log_type
      exempted_members = audit_log_config.value.exempted_members
    }
  }
}

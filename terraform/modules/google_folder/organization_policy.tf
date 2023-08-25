locals {
  folder_policy_pairs = flatten([
    for k, v in var.folders : v.org_policy != null ? [
      for policy in v.org_policy : {
        folder = k
        policy = policy
      }
    ] : []
  ])
}

resource "google_folder_organization_policy" "folder_organization_policy" {
  for_each = { for pair in local.folder_policy_pairs : "${pair.folder}.${pair.policy.constraint}" => pair }

  folder = local.folder_id[each.value.folder]

  constraint = each.value.policy.constraint
  version    = each.value.policy.version != null ? each.value.policy.version : 0

  dynamic "boolean_policy" {
    for_each = each.value.policy.boolean_policy != null ? [each.value.policy.boolean_policy] : []
    content {
      enforced = boolean_policy.value.enforced
    }
  }

  dynamic "list_policy" {
    for_each = each.value.policy.list_policy != null ? [each.value.policy.list_policy] : []
    content {
      dynamic "allow" {
        for_each = list_policy.value.allow != null ? [list_policy.value.allow] : []
        content {
          all    = allow.value.all
          values = allow.value.values
        }
      }

      dynamic "deny" {
        for_each = list_policy.value.deny != null ? [list_policy.value.deny] : []
        content {
          all    = deny.value.all
          values = deny.value.values
        }
      }

      suggested_value     = list_policy.value.suggested_value
      inherit_from_parent = list_policy.value.inherit_from_parent
    }
  }

  dynamic "restore_policy" {
    for_each = each.value.policy.restore_policy != null ? [each.value.policy.restore_policy] : []
    content {
      default = restore_policy.value.default
    }
  }
}

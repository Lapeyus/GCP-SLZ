variable "folders" {
  type = map(object({
    name               = optional(string)
    external_parent_id = optional(string)
    parent_entry_key   = optional(string)
    iam                = optional(map(list(string)))
    iam_mode           = optional(string)
    audit_logs = optional(map(object({
      service          = optional(string)
      log_type         = optional(string)
      exempted_members = optional(list(string))
    })))
    org_policy = optional(list(object({
      constraint = optional(string)
      version    = optional(string)
      boolean_policy = optional(object({
        enforced = optional(bool)
      }))
      list_policy = optional(object({
        allow = optional(object({
          all    = optional(bool)
          values = optional(list(string))
        }))
        deny = optional(object({
          all    = optional(bool)
          values = optional(list(string))
        }))
        suggested_value     = optional(string)
        inherit_from_parent = optional(bool)
      }))
      restore_policy = optional(object({
        default = optional(bool)
      }))
    })))
  }))
  default = {}
}

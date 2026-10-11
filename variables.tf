variable "csi_driver_v1s" {
  description = <<EOT
Map of csi_driver_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
Optional:
    - spec (block):
        - attach_required (required)
        - pod_info_on_mount (optional)
        - volume_lifecycle_modes (optional)
EOT

  type = map(object({
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
    })
    spec = optional(object({
      attach_required        = bool
      pod_info_on_mount      = optional(bool)
      volume_lifecycle_modes = optional(list(string))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.csi_driver_v1s : (
        v.spec == null || (v.spec.volume_lifecycle_modes == null || (alltrue([for x in v.spec.volume_lifecycle_modes : contains(["Persistent", "Ephemeral"], x)])))
      )
    ])
    error_message = "must be one of: \"Persistent\", \"Ephemeral\""
  }
}


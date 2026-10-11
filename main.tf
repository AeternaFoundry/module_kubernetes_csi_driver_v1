resource "kubernetes_csi_driver_v1" "csi_driver_v1s" {
  for_each = var.csi_driver_v1s


  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
  }

  dynamic "spec" {
    for_each = each.value.spec != null ? [each.value.spec] : []
    content {
      attach_required        = spec.value.attach_required
      pod_info_on_mount      = spec.value.pod_info_on_mount
      volume_lifecycle_modes = spec.value.volume_lifecycle_modes
    }
  }
}


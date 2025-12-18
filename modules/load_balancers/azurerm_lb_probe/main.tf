resource "azurerm_lb_probe" "lbprobe" {
  for_each = var.lb_probes

  name                = each.value.hpb_name
  loadbalancer_id     = data.azurerm_lb.lb[each.key].id
  port                = each.value.port
  protocol            = each.value.protocol
  interval_in_seconds = each.value.interval_in_seconds

  # Uncomment if you want to use HTTP probes
  #request_path       = each.value.request_path
}

resource "azurerm_lb_rule" "lbr" {
  for_each = var.lb_rules

  name                           = each.value.lbr_name
  loadbalancer_id                = data.azurerm_lb.lb[each.key].id
  backend_address_pool_ids       = [data.azurerm_lb_backend_address_pool.bepool[each.key].id]
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  probe_id                       = var.probe_id[each.value.probe_key]
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
}

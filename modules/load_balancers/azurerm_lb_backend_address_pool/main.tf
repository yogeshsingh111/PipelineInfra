resource "azurerm_lb_backend_address_pool" "bepool" {
  for_each = var.backend_pools

  name            = each.value.lb_bpoolname
  loadbalancer_id = data.azurerm_lb.lb[each.key].id
  # Uncomment if you want to associate with a virtual network
  # virtual_network_id = each.value.virtual_network_id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_bepool" {
  for_each = var.nic_bpool_associ

  network_interface_id    = data.azurerm_network_interface.nic[each.key].id
  ip_configuration_name   = each.value.nic_ip_configuration_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.bepool[each.key].id
}

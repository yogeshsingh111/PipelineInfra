data "azurerm_lb" "lb" {
  for_each = var.lb_rules
  name                = each.value.lb_name
  resource_group_name = var.rg_name[each.value.rg_key]
}


data "azurerm_lb_backend_address_pool" "bepool" {
  for_each = var.lb_rules
  name                = each.value.lb_bpoolname
  loadbalancer_id = data.azurerm_lb.lb[each.key].id
}


data "azurerm_lb" "lb" {
  for_each = var.backend_pools
  name                = each.value.lb_name
  resource_group_name = var.rg_name[each.value.rg_key]
}


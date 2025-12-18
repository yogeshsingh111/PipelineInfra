data "azurerm_lb" "lb" {
  for_each            = var.lb_probes
  name                = each.value.lb_name
  resource_group_name = var.rg_name[each.value.rg_key]
}

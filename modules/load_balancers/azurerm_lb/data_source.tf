data "azurerm_public_ip" "lb_pip" {
  for_each = var.load_balancers
  name                = each.value.lb_pip_name
  resource_group_name = var.rg_name[each.value.rg_key]
}

data "azurerm_subnet" "bastion_sub" {
  for_each = var.load_balancers

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = var.rg_name[each.value.rg_key]
}

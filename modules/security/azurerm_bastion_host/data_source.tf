data "azurerm_subnet" "bastion_sub" {
  for_each = var.bastions

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = var.rg_names[each.value.rg_key]
}

data "azurerm_public_ip" "bastion_pip" {
  for_each = var.bastions

  name                = each.value.bastion_pip_name
  resource_group_name = var.rg_names[each.value.rg_key]
}

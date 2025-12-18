resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastions

  name                = each.value.bastion_host_name
  location            = each.value.location
  resource_group_name = var.rg_names[each.value.rg_key]
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion_sub[each.key].id
    public_ip_address_id = data.azurerm_public_ip.bastion_pip[each.key].id
  }
}

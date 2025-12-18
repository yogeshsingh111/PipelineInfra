resource "azurerm_container_registry" "acr" {
  for_each = var.acr_instances

  name                = each.value.acr_name
  resource_group_name = var.rg_name[each.value.rg_key]
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled

  dynamic "georeplications" {
    for_each = each.value.georeplications
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
      tags                    = georeplications.value.tags
    }
  }
}


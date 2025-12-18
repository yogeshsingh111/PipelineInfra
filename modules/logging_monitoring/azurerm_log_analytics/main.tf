resource "azurerm_log_analytics_workspace" "law" {
  for_each = var.log_analytics_workspaces

  name                = each.value.law_name
  location            = each.value.location
  resource_group_name = var.rg_name[each.value.rg_key]
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days
}


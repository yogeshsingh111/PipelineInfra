data "azurerm_container_registry" "acr" {
  for_each = var.aks_acr_role_assignments

  name                = each.value.acr_name
  resource_group_name = var.rg_name[each.value.rg_key]
}

data "azurerm_kubernetes_cluster" "aks" {
   for_each = var.aks_acr_role_assignments


  name                = each.value.aks_name
  resource_group_name = var.rg_name[each.value.rg_key]
}


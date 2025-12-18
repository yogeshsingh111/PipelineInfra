resource "azurerm_role_assignment" "aksrass" {
  for_each = var.aks_acr_role_assignments

  principal_id                     = data.azurerm_kubernetes_cluster.aks[each.key].identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr[each.key].id
  skip_service_principal_aad_check = true
}

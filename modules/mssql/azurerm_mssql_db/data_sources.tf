data "azurerm_mssql_server" "servers" {
  for_each = var.sql_databases

  name                = each.value.server_name
  resource_group_name = var.rg_name[each.value.rg_key]
}

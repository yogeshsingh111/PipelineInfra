resource "azurerm_mssql_server" "sqlserver" {
  for_each = var.sql_servers

  name                         = each.value.sqlserver_name
  resource_group_name          = var.rg_name[each.value.rg_key]
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.sql_user[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.sql_pass[each.key].value
  connection_policy            = lookup(each.value, "connection_policy", "Default")

  # Optional: Managed Identity
  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type = identity.value.type
    }
  }



  tags = lookup(each.value, "tags", null)
}

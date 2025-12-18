data "azurerm_key_vault" "kv" {
  for_each = var.sql_servers

  name                = each.value.kv_name
  resource_group_name = var.rg_name[each.value.rg_key]
}

# fetch sql useranme
data "azurerm_key_vault_secret" "sql_user" {
  for_each = var.sql_servers

  name         = each.value.sql_user_secret
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

# Fetch sql password 
data "azurerm_key_vault_secret" "sql_pass" {
  for_each = var.sql_servers

  name         = each.value.sql_pass_secret
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

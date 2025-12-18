resource "azurerm_lb" "lb" {
  for_each = var.load_balancers

  # Required
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = var.rg_name[each.value.rg_key]

  # Optional (Top-Level)
  edge_zone = lookup(each.value, "edge_zone", null)
  sku       = lookup(each.value, "sku", null)
  sku_tier  = lookup(each.value, "sku_tier", null)
  tags      = lookup(each.value, "tags", null)

  # frontend_ip_configuration (repeatable block)
  dynamic "frontend_ip_configuration" {
    for_each = lookup(each.value, "frontend_ip_configuration", [])

    content {
      name                                               = frontend_ip_configuration.value.name
      zones                                              = lookup(frontend_ip_configuration.value, "zones", null)
      #If subnet_id is set → LB is Internal/private.
      #subnet_id                                          = data.azurerm_subnet.bastion_sub[each.key].id
      gateway_load_balancer_frontend_ip_configuration_id = lookup(frontend_ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      private_ip_address                                 = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      private_ip_address_allocation                      = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
      private_ip_address_version                         = lookup(frontend_ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id                               = data.azurerm_public_ip.lb_pip[each.key].id
      public_ip_prefix_id                                = lookup(frontend_ip_configuration.value, "public_ip_prefix_id", null)
    }
  }
}

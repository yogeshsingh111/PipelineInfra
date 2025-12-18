
# resource "azurerm_lb_outbound_rule" "example" {
#   name                    = "OutboundRule"
#   loadbalancer_id         = azurerm_lb.example.id
#   protocol                = "Tcp"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.example.id

#   frontend_ip_configuration {
#     name = "PublicIPAddress"
#   }
# }
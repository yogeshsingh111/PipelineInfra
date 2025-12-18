variable "load_balancers" {
  type = map(object({
    # Required
    lb_name     = string
    location    = string
    rg_key      = string
    lb_pip_name = string
    subnet_name = string
    vnet_name   = string
    # Optional (Top-Level)
    #edge_zone = optional(string)
    sku       = optional(string)
    sku_tier  = optional(string)
    tags      = optional(map(string))

    # frontend_ip_configuration (list of objects)
    frontend_ip_configuration = optional(list(object({
      name                                               = string
      zones                                              = optional(list(string))
      #subnet_id                                          = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address                                 = optional(string)
      private_ip_address_allocation                      = optional(string)
      private_ip_address_version                         = optional(string)
      #public_ip_address_id                               = optional(string)
      public_ip_prefix_id                                = optional(string)
    })))
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

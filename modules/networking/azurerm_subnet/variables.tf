# variable "subnets" {
#   description = "Map of subnet configurations to create."
#   type = map(object({
#     subnet_name                                   = string
#     virtual_network_name                          = string
#     default_outbound_access_enabled               = optional(bool, true)
#     private_endpoint_network_policies             = optional(string, "Disabled")
#     private_link_service_network_policies_enabled = optional(bool, true)
#     sharing_scope                                 = optional(string)
#     service_endpoints                             = optional(list(string))
#     service_endpoint_policy_ids                   = optional(list(string))
#     rg_key                                        = string

#     # Either one must be set
#     address_prefixes = optional(list(string))

#     ip_address_pool = optional(object({
#       id                     = string
#       number_of_ip_addresses = string
#     }))

#     # Optional configurations
#     delegation = optional(list(object({
#       name = string
#       service_delegation = object({
#         name    = string
#         actions = optional(list(string))
#       })
#     })))


#   }))
# }

variable "subnets" {
  description = "Map of subnet configurations to create."

  type = map(object({
    subnet_name                      = string
    virtual_network_name             = string
    rg_key                           = string

    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))

    # Either address_prefixes OR ip_address_pool is required (logic you will enforce in locals)
    address_prefixes = optional(list(string))

    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))

    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
  }))

  default = {}
}



variable "rg_names" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

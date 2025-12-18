variable "acr_instances" {
  type = map(object({
    location      = string
    rg_key        = string
    acr_name      = string
    sku           = string
    admin_enabled = bool
    georeplications = map(object({
      location                = string
      zone_redundancy_enabled = bool
      tags                    = map(string)
    }))
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

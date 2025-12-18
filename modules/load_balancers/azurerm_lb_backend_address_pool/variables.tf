variable "backend_pools" {
  type = map(object({
    lb_bpoolname = string
    rg_key       = string
    lb_name      = string
    # virtual_network_id = optional(string)
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

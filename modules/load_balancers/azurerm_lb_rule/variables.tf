variable "lb_rules" {
  type = map(object({
    lb_name      = string
    rg_key       = string
    probe_key    = string
    lb_bpoolname = string
    lbr_name     = string
    #backend_address_pool_ids       = list(string)
    protocol                       = string
    frontend_port                  = number
    backend_port                   = number
    frontend_ip_configuration_name = string
    idle_timeout_in_minutes        = number
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

variable "probe_id" {
  description = "probr id"
  type        = map(string)

}

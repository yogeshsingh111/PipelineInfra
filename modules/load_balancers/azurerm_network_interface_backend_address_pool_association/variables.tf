variable "nic_bpool_associ" {
  type = map(object({
    rg_key                    = string
    nic_ip_configuration_name = string
    nic_name                  = string
    lb_name                   = string
    lb_bpoolname              = string

  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}


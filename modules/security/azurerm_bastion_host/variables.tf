variable "bastions" {
  type = map(object({
    bastion_host_name    = string
    location             = string
    rg_key               = string
    subnet_name          = string
    vnet_name            = string
    bastion_pip_name     = string
  }))
}

variable "rg_names" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

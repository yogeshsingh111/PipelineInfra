variable "aks_acr_role_assignments" {
  type = map(object({
    acr_name = string
    aks_name = string
    rg_key = string
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

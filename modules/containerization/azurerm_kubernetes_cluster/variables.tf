variable "aks_clusters" {
  type = map(object({
    cluster_name = string
    location     = string
    rg_key       = string
    node_count   = number
    vm_size      = string
    dns_prefix   = string
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

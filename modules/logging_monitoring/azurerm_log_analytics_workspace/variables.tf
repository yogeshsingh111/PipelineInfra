variable "log_analytics_workspaces" {
  type = map(object({
    location          = string
    sku               = string
    rg_key            = string
    retention_in_days = number
    law_name          = string
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

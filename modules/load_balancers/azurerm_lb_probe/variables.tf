variable "lb_probes" {
  type = map(object({
    hpb_name            = string
    lb_name             = string
    rg_key              = string
    port                = number
    protocol            = string
    interval_in_seconds = number
    #request_path       = optional(string)
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}


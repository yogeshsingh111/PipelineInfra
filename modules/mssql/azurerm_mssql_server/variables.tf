# variable "sql_servers" {
#   description = "Configuration for multiple Azure SQL Servers"
#   type = map(object({
#     sqlserver_name    = string
#     rg_key            = string
#     location          = string
#     version           = string
#     kv_name           = string
#     sql_user_secret   = string
#     sql_pass_secret   = string
#     connection_policy = optional(string, "Default")
#     # Optional identity block
#     identity = optional(object({
#       type = string
#     }))

#     tags = optional(map(string))
#   }))
# }

variable "sql_servers" {
  description = "Configuration for multiple Azure SQL Servers"

  type = map(object({
    sqlserver_name    = string
    rg_key            = string
    location          = string
    version           = string
    kv_name           = string
    sql_user_secret   = string
    sql_pass_secret   = string

    connection_policy = optional(string)

    identity = optional(object({
      type = string
    }))

    tags = optional(map(string))
  }))

  default = {}
}



variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

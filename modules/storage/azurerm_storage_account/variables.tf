# variable "stgaccount" {
#   description = "A map of storage accounts to create. The key of the map will be used as the storage account identifier."
#   type = map(object({

#     # Required Arguments
#     name                     = string
#     location                 = string
#     rg_key                   = string
#     account_tier             = string
#     account_replication_type = string

#     # Optional Arguments
#     account_kind                      = optional(string)
#     provisioned_billing_model_version = optional(string)
#     tags                              = optional(map(string))
#     cross_tenant_replication_enabled  = optional(bool)
#     access_tier                       = optional(string)
#     edge_zone                         = optional(string)
#     https_traffic_only_enabled        = optional(bool)
#     min_tls_version                   = optional(string)
#     allow_nested_items_to_be_public   = optional(bool)
#     shared_access_key_enabled         = optional(bool)
#     public_network_access_enabled     = optional(bool)
#     default_to_oauth_authentication   = optional(bool)
#     is_hns_enabled                    = optional(bool)
#     nfsv3_enabled                     = optional(bool)
#     large_file_share_enabled          = optional(bool)
#     local_user_enabled                = optional(bool)
#     queue_encryption_key_type         = optional(string)
#     table_encryption_key_type         = optional(string)
#     infrastructure_encryption_enabled = optional(bool)
#     allowed_copy_scope                = optional(string)
#     sftp_enabled                      = optional(bool)
#     dns_endpoint_type                 = optional(string)


#     # Block Arguments (Optional Arguments)
#     custom_domain = optional(object({
#       name          = string
#       use_subdomain = optional(bool)
#     }))

#     customer_managed_key = optional(object({
#       user_assigned_identity_id = string
#       key_vault_key_id          = optional(string)
#       managed_hsm_key_id        = optional(string)
#     }))

#     identity = optional(object({
#       type         = string
#       identity_ids = list(string)
#     }))

#     blob_properties = optional(object({
#       cors_rule = optional(list(object({
#         allowed_headers    = list(string)
#         allowed_methods    = list(string)
#         allowed_origins    = list(string)
#         exposed_headers    = list(string)
#         max_age_in_seconds = number
#       })), [])
#       delete_retention_policy = optional(object({
#         days = number
#       }), { days = 7 })
#       restore_policy = optional(object({
#         days = number
#       }), { days = 7 })
#       versioning_enabled            = optional(bool)
#       change_feed_enabled           = optional(bool)
#       change_feed_retention_in_days = optional(number)
#       default_service_version       = optional(string)
#       last_access_time_enabled      = optional(bool)
#       container_delete_retention_policy = optional(object({
#         days = optional(number)
#       }))
#     }))

#     queue_properties = optional(object({
#       cors_rule = optional(list(object({
#         allowed_headers    = list(string)
#         allowed_methods    = list(string)
#         allowed_origins    = list(string)
#         exposed_headers    = list(string)
#         max_age_in_seconds = number
#       })), [])
#       logging = optional(object({
#         delete                = bool
#         read                  = bool
#         write                 = bool
#         version               = string
#         retention_policy_days = optional(number)
#       }))
#       hour_metrics = optional(object({
#         enabled               = bool
#         version               = string
#         include_apis          = optional(bool)
#         retention_policy_days = optional(number)
#       }))
#       minute_metrics = optional(object({
#         enabled               = bool
#         version               = string
#         include_apis          = optional(bool)
#         retention_policy_days = optional(number)
#       }))
#     }))

#     static_website = optional(object({
#       index_document     = optional(string)
#       error_404_document = optional(string)
#     }))

#     share_properties = optional(object({
#       cors_rule = optional(list(object({
#         allowed_headers    = list(string)
#         allowed_methods    = list(string)
#         allowed_origins    = list(string)
#         exposed_headers    = list(string)
#         max_age_in_seconds = number
#       })), [])
#       retention_policy = optional(object({
#         days = number
#       }))
#       smb = optional(object({
#         versions                        = list(string)
#         authentication_types            = list(string)
#         kerberos_ticket_encryption_type = string
#         channel_encryption_type         = string
#         multichannel_enabled            = bool
#       }))
#     }))

#     network_rules = optional(object({
#       default_action             = string
#       bypass                     = optional(list(string), [])
#       virtual_network_subnet_ids = optional(list(string), [])
#       ip_rules                   = optional(list(string), [])
#       private_link_access = optional(object({
#         endpoint_resource_id = string
#         endpoint_tenant_id   = optional(string)
#       }))
#     }))

#     azure_files_authentication = optional(object({
#       directory_type                 = optional(string)
#       default_share_level_permission = optional(string)
#       active_directory = object({
#         domain_name         = optional(string)
#         netbios_domain_name = optional(string)
#         forest_name         = optional(string)
#         domain_guid         = optional(string)
#         domain_sid          = optional(string)
#         storage_sid         = optional(string)
#       })
#       })
#     )

#     routing = optional(object({
#       choice                      = string
#       publish_microsoft_endpoints = bool
#       publish_internet_endpoints  = bool
#     }))

#     immutability_policy = optional(object({
#       state                         = string
#       allow_protected_append_writes = bool
#       period_since_creation_in_days = number
#     }))

#     sas_policy = optional(object({
#       expiration_period = string
#       expiration_action = string

#     }))

#   }))
# }

variable "stgaccount" {
  description = "A map of storage accounts to create"
  type = map(object({

    name                     = string
    location                 = string
    rg_key                   = string
    account_tier             = string
    account_replication_type = string

    account_kind                      = optional(string)
    provisioned_billing_model_version = optional(string)
    tags                              = optional(map(string))
    cross_tenant_replication_enabled  = optional(bool)
    access_tier                       = optional(string)
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(bool)
    min_tls_version                   = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    public_network_access_enabled     = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    is_hns_enabled                    = optional(bool)
    nfsv3_enabled                     = optional(bool)
    large_file_share_enabled          = optional(bool)
    local_user_enabled                = optional(bool)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    allowed_copy_scope                = optional(string)
    sftp_enabled                      = optional(bool)
    dns_endpoint_type                 = optional(string)

    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))

    customer_managed_key = optional(object({
      user_assigned_identity_id = string
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))

    blob_properties = optional(object({
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))

      delete_retention_policy = optional(object({
        days = number
      }))

      restore_policy = optional(object({
        days = number
      }))

      versioning_enabled            = optional(bool)
      change_feed_enabled           = optional(bool)
      change_feed_retention_in_days = optional(number)
      default_service_version       = optional(string)
      last_access_time_enabled      = optional(bool)

      container_delete_retention_policy = optional(object({
        days = optional(number)
      }))
    }))

    queue_properties = optional(object({
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))

      logging = optional(object({
        delete                = bool
        read                  = bool
        write                 = bool
        version               = string
        retention_policy_days = optional(number)
      }))

      hour_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))

      minute_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
    }))

    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))

    share_properties = optional(object({
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))

      retention_policy = optional(object({
        days = number
      }))

      smb = optional(object({
        versions                        = list(string)
        authentication_types            = list(string)
        kerberos_ticket_encryption_type = string
        channel_encryption_type         = string
        multichannel_enabled            = bool
      }))
    }))

    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
      ip_rules                   = optional(list(string))

      private_link_access = optional(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      }))
    }))

    azure_files_authentication = optional(object({
      directory_type                 = optional(string)
      default_share_level_permission = optional(string)

      active_directory = object({
        domain_name         = optional(string)
        netbios_domain_name = optional(string)
        forest_name         = optional(string)
        domain_guid         = optional(string)
        domain_sid          = optional(string)
        storage_sid         = optional(string)
      })
    }))

    routing = optional(object({
      choice                      = string
      publish_microsoft_endpoints = bool
      publish_internet_endpoints  = bool
    }))

    immutability_policy = optional(object({
      state                         = string
      allow_protected_append_writes = bool
      period_since_creation_in_days = number
    }))

    sas_policy = optional(object({
      expiration_period = string
      expiration_action = string
    }))

  }))

  default = {}
}


variable "rg_names" {
  description = "Map of RG names from RG module"
  type        = map(string)
}


resource "azurerm_storage_account" "stg" {
  for_each = var.stgaccount

  # Required Arguments
  name                     = each.value.name
  resource_group_name      = var.rg_names[each.value.rg_key]
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  # Optional Arguments
  account_kind                      = try(each.value.account_kind, null)
  tags                              = try(each.value.tags, null)
  provisioned_billing_model_version = try(each.value.provisioned_billing_model_version, null)
  cross_tenant_replication_enabled  = try(each.value.cross_tenant_replication_enabled, null)
  edge_zone                         = try(each.value.edge_zone, null)
  https_traffic_only_enabled        = try(each.value.https_traffic_only_enabled, null)
  min_tls_version                   = try(each.value.min_tls_version, null)
  shared_access_key_enabled         = try(each.value.shared_access_key_enabled, null)
  allow_nested_items_to_be_public   = try(each.value.allow_nested_items_to_be_public, null)
  public_network_access_enabled     = try(each.value.public_network_access_enabled, null)
  default_to_oauth_authentication   = try(each.value.default_to_oauth_authentication, null)
  is_hns_enabled                    = try(each.value.is_hns_enabled, null)
  nfsv3_enabled                     = try(each.value.nfsv3_enabled, null)
  large_file_share_enabled          = try(each.value.large_file_share_enabled, null)
  local_user_enabled                = try(each.value.local_user_enabled, null)
  queue_encryption_key_type         = try(each.value.queue_encryption_key_type, null)
  table_encryption_key_type         = try(each.value.table_encryption_key_type, null)
  infrastructure_encryption_enabled = try(each.value.infrastructure_encryption_enabled, null)
  dns_endpoint_type                 = try(each.value.dns_endpoint_type, null)
  sftp_enabled                      = try(each.value.sftp_enabled, null)
  allowed_copy_scope                = try(each.value.allowed_copy_scope, null)


  # Block Arguments (Optional Arguments)

  # Yeh (custom_domain) tab kaam karega without dynamic block, -
  # -only jab hum custom_domain me sabhi arguments ki value ko tfvars me paas karnege.
  # ✅ Hamesha present hai(matalab ki iska use karunga tab mujhe iski value tfvars me dena hoga)
  # ✅ Agar aap custom_domain ki values provide nahi karte:
  # - Toh Terraform plan/run fail karega with an error like:
  #     - Error: Unsupported attribute
  #     - This object does not have an attribute named "custom_domain".
  # ✅ Aur yeh block resource/module ke syntax ke according valid hai.(jab values paas kareng tab kaam karega)

  # custom_domain {
  #   name          = each.value.custom_domain.name
  #   use_subdomain = each.value.custom_domain.use_subdomain
  # }

  dynamic "custom_domain" {
    for_each = each.value.custom_domain != null ? [each.value.custom_domain] : []
    content {
      name          = custom_domain.value.name
      use_subdomain = try(custom_domain.value.use_subdomain, null)
    }
  }

  dynamic "customer_managed_key" {
    for_each = each.value.customer_managed_key != null ? [each.value.customer_managed_key] : []
    content {
      user_assigned_identity_id = try(customer_managed_key.value.user_assigned_identity_id, null)
      key_vault_key_id          = try(customer_managed_key.value.key_vault_key_id, null)
      managed_hsm_key_id        = try(customer_managed_key.value.managed_hsm_key_id, null)
    }
  }


  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = try(identity.value.type, null)
      identity_ids = try(identity.value.identity_ids, null)
    }
  }


  dynamic "blob_properties" {
    for_each = each.value.blob_properties != null ? [each.value.blob_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = try(blob_properties.value.cors_rule, [])
        content {
          allowed_headers    = try(cors_rule.value.allowed_headers, null)
          allowed_methods    = try(cors_rule.value.allowed_methods, null)
          allowed_origins    = try(cors_rule.value.allowed_origins, null)
          exposed_headers    = try(cors_rule.value.exposed_headers, null)
          max_age_in_seconds = try(cors_rule.value.max_age_in_seconds, null)
        }
      }

      dynamic "delete_retention_policy" {
        for_each = try(blob_properties.value.delete_retention_policy, null) != null ? [blob_properties.value.delete_retention_policy] : []
        content {
          days = try(delete_retention_policy.value.days, null)
        }
      }

      dynamic "restore_policy" {
        for_each = try(blob_properties.value.restore_policy, null) != null ? [blob_properties.value.restore_policy] : []
        content {
          days = try(restore_policy.value.days, null)
        }
      }

      versioning_enabled            = try(blob_properties.value.versioning_enabled, null)
      change_feed_enabled           = try(blob_properties.value.change_feed_enabled, null)
      change_feed_retention_in_days = try(blob_properties.value.change_feed_retention_in_days, null)
      default_service_version       = try(blob_properties.value.default_service_version, null)
      last_access_time_enabled      = try(blob_properties.value.last_access_time_enabled, null)

      dynamic "container_delete_retention_policy" {
        for_each = try(blob_properties.value.container_delete_retention_policy, null) != null ? [blob_properties.value.container_delete_retention_policy] : []
        content {
          days = try(container_delete_retention_policy.value.days, null)
        }
      }
    }
  }


  dynamic "queue_properties" {
    for_each = each.value.queue_properties != null ? [each.value.queue_properties] : []
    content {

      dynamic "cors_rule" {
        for_each = try(queue_properties.value.cors_rule, [])
        content {
          allowed_headers    = try(cors_rule.value.allowed_headers, null)
          allowed_methods    = try(cors_rule.value.allowed_methods, null)
          allowed_origins    = try(cors_rule.value.allowed_origins, null)
          exposed_headers    = try(cors_rule.value.exposed_headers, null)
          max_age_in_seconds = try(cors_rule.value.max_age_in_seconds, null)
        }
      }

      dynamic "logging" {
        for_each = try(queue_properties.value.logging, null) != null ? [queue_properties.value.logging] : []
        content {
          delete                = try(logging.value.delete, null)
          read                  = try(logging.value.read, null)
          write                 = try(logging.value.write, null)
          version               = try(logging.value.version, null)
          retention_policy_days = try(logging.value.retention_policy_days, null)
        }
      }

      dynamic "hour_metrics" {
        for_each = try(queue_properties.value.hour_metrics, null) != null ? [queue_properties.value.hour_metrics] : []
        content {
          enabled               = try(hour_metrics.value.enabled, null)
          version               = try(hour_metrics.value.version, null)
          include_apis          = try(hour_metrics.value.include_apis, null)
          retention_policy_days = try(hour_metrics.value.retention_policy_days, null)
        }
      }

      dynamic "minute_metrics" {
        for_each = try(queue_properties.value.minute_metrics, null) != null ? [queue_properties.value.minute_metrics] : []
        content {
          enabled               = try(minute_metrics.value.enabled, null)
          version               = try(minute_metrics.value.version, null)
          include_apis          = try(minute_metrics.value.include_apis, null)
          retention_policy_days = try(minute_metrics.value.retention_policy_days, null)
        }
      }

    }
  }

  dynamic "static_website" {
    for_each = each.value.static_website != null ? [each.value.static_website] : []
    content {
      index_document     = try(static_website.value.index_document, null)
      error_404_document = try(static_website.value.error_404_document, null)
    }
  }


  dynamic "share_properties" {
    for_each = each.value.share_properties != null ? [each.value.share_properties] : []
    content {

      dynamic "cors_rule" {
        for_each = try(share_properties.value.cors_rule, [])
        content {
          allowed_headers    = try(cors_rule.value.allowed_headers, null)
          allowed_methods    = try(cors_rule.value.allowed_methods, null)
          allowed_origins    = try(cors_rule.value.allowed_origins, null)
          exposed_headers    = try(cors_rule.value.exposed_headers, null)
          max_age_in_seconds = try(cors_rule.value.max_age_in_seconds, null)
        }
      }

      dynamic "retention_policy" {
        for_each = try(share_properties.value.retention_policy, null) != null ? [share_properties.value.retention_policy] : []
        content {
          days = try(retention_policy.value.days, null)
        }
      }

      dynamic "smb" {
        for_each = try(share_properties.value.smb, null) != null ? [share_properties.value.smb] : []
        content {
          versions                        = try(smb.value.versions, null)
          authentication_types            = try(smb.value.authentication_types, null)
          kerberos_ticket_encryption_type = try(smb.value.kerberos_ticket_encryption_type, null)
          channel_encryption_type         = try(smb.value.channel_encryption_type, null)
          multichannel_enabled            = try(smb.value.multichannel_enabled, null)
        }
      }

    }
  }

  dynamic "network_rules" {
    for_each = each.value.network_rules != null ? [each.value.network_rules] : []
    content {
      default_action             = try(network_rules.value.default_action, null)
      bypass                     = try(network_rules.value.bypass, null)
      virtual_network_subnet_ids = try(network_rules.value.virtual_network_subnet_ids, null)
      ip_rules                   = try(network_rules.value.ip_rules, null)

      dynamic "private_link_access" {
        for_each = try(network_rules.value.private_link_access, null) != null ? [network_rules.value.private_link_access] : []
        content {
          endpoint_resource_id = try(private_link_access.value.endpoint_resource_id, null)
          endpoint_tenant_id   = try(private_link_access.value.endpoint_tenant_id, null)
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = each.value.azure_files_authentication != null ? [each.value.azure_files_authentication] : []
    content {
      directory_type                 = try(azure_files_authentication.value.directory_type, null)
      default_share_level_permission = try(azure_files_authentication.value.default_share_level_permission, null)

      dynamic "active_directory" {
        for_each = try(azure_files_authentication.value.active_directory, null) != null ? [azure_files_authentication.value.active_directory] : []
        content {
          domain_name         = try(active_directory.value.domain_name, null)
          netbios_domain_name = try(active_directory.value.netbios_domain_name, null)
          forest_name         = try(active_directory.value.forest_name, null)
          domain_guid         = try(active_directory.value.domain_guid, null)
          domain_sid          = try(active_directory.value.domain_sid, null)
          storage_sid         = try(active_directory.value.storage_sid, null)
        }
      }
    }
  }

  dynamic "routing" {
    for_each = each.value.routing != null ? [each.value.routing] : []
    content {
      choice                      = try(routing.value.choice, null)
      publish_microsoft_endpoints = try(routing.value.publish_microsoft_endpoints, null)
      publish_internet_endpoints  = try(routing.value.publish_internet_endpoints, null)
    }
  }

  dynamic "immutability_policy" {
    for_each = each.value.immutability_policy != null ? [each.value.immutability_policy] : []
    content {
      state                         = try(immutability_policy.value.state, null)
      allow_protected_append_writes = try(immutability_policy.value.allow_protected_append_writes, null)
      period_since_creation_in_days = try(immutability_policy.value.period_since_creation_in_days, null)
    }
  }


  dynamic "sas_policy" {
    for_each = each.value.sas_policy != null ? [each.value.sas_policy] : []
    content {
      expiration_action = try(sas_policy.value.expiration_action, null)
      expiration_period = try(sas_policy.value.expiration_period, null)
    }
  }
}


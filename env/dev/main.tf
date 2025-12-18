module "rg" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage" {
  depends_on = [module.rg]
  source     = "../../modules/storage/azurerm_storage_account"
  stgaccount = var.stgaccount
  rg_names   = module.rg.names
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../modules/networking/azurerm_vnet"
  vnets      = var.vnets
  rg_names   = module.rg.names
}

module "subnet" {
  depends_on = [module.rg, module.vnet]
  source     = "../../modules/networking/azurerm_subnet"
  subnets    = var.subnets
  rg_names   = module.rg.names
}

module "pips" {
  depends_on = [module.rg]
  source     = "../../modules/networking/azurerm_public_ip"
  pips       = var.pips
  rg_names   = module.rg.names
}

module "nics" {
  depends_on = [module.rg, module.pips, module.subnet, module.vnet, module.lb, module.lb_bpool]
  source     = "../../modules/networking/azurerm_nic"
  nics       = var.nics
  rg_name    = module.rg.names
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/security/azurerm_network_security_group"
  nsg        = var.nsg
  rg_names   = module.rg.names
}

module "association" {
  depends_on  = [module.rg, module.nsg, module.nics]
  source      = "../../modules/security/azurerm_nsg_nic_assoc"
  nic_ids     = module.nics.nic_ids
  nsg_ids     = module.nsg.nsg_ids
  nic_nsg_map = var.nic_nsg_map
}

module "kv" {
  depends_on = [module.rg]
  source     = "../../modules/security/azurerm_key_vault"
  key_vaults = var.key_vaults
  rg_names   = module.rg.names
}

module "kvs" {
  depends_on        = [module.rg, module.kv]
  source            = "../../modules/security/azurerm_key_vault_secret"
  key_vault_secrets = var.key_vault_secrets
  rg_names          = module.rg.names
}

module "lvm" {
  depends_on = [module.rg, module.nics, module.pips, module.nsg, module.kv, module.kvs, module.association , module.lb, module.lb_bpool, module.nic_lbbpool_associ]
  source     = "../../modules/virtual_machines/azurerm_linux_virtual_machine"
  lvm        = var.lvm
  rg_names   = module.rg.names
}

module "wvm" {
  depends_on = [module.rg, module.nics, module.pips, module.nsg, module.kv, module.kvs, module.association, module.lb, module.lb_bpool, module.nic_lbbpool_associ]
  source     = "../../modules/virtual_machines/azurerm_windows_virtual_machine"
  wvm        = var.wvm
  rg_name    = module.rg.names
}

module "sqlserver" {
  depends_on  = [module.rg, module.kv, module.kvs, module.kv, module.kvs]
  source      = "../../modules/mssql/azurerm_mssql_server"
  sql_servers = var.sql_servers
  rg_name     = module.rg.names
}

module "sqldb" {
  depends_on    = [module.rg, module.sqlserver, module.kv, module.kvs]
  source        = "../../modules/mssql/azurerm_mssql_db"
  sql_databases = var.sql_databases
  rg_name       = module.rg.names
}

module "log_analytics_workspaces" {
  depends_on               = [module.rg]
  source                   = "../../modules/logging_monitoring/azurerm_log_analytics_workspace"
  log_analytics_workspaces = var.log_analytics_workspaces
  rg_name                  = module.rg.names
}

module "bastion" {
  depends_on = [module.rg, module.vnet, module.subnet, module.pips]
  source     = "../../modules/security/azurerm_bastion_host"
  bastions   = var.bastions
  rg_names   = module.rg.names
}

# module "aks" {
#   depends_on   = [module.rg]
#   source       = "../../modules/containerization/azurerm_kubernetes_cluster"
#   aks_clusters = var.aks_clusters
#   rg_name      = module.rg.names
# }

# module "acr_instances" {
#   depends_on    = [module.rg, module.aks]
#   source        = "../../modules/containerization/azurerm_container_registry"
#   acr_instances = var.acr_instances
#   rg_name       = module.rg.names
# }

# module "aks_acr_assign" {
#   depends_on               = [module.aks, module.acr_instances]
#   source                   = "../../modules/containerization/azurerm_role_assignment_aks_attach_to_acr"
#   aks_acr_role_assignments = var.aks_acr_role_assignments
#   rg_name                  = module.rg.names

# }

module "lb" {
  depends_on     = [module.rg, module.pips, module.subnet, module.vnet]
  source         = "../../modules/load_balancers/azurerm_lb"
  load_balancers = var.load_balancers
  rg_name        = module.rg.names
}

module "lb_bpool" {
  depends_on    = [module.rg, module.pips, module.subnet, module.vnet, module.lb]
  source        = "../../modules/load_balancers/azurerm_lb_backend_address_pool"
  backend_pools = var.backend_pools
  rg_name       = module.rg.names
}

module "lb_hprobe" {
  depends_on = [module.rg, module.pips, module.subnet, module.vnet, module.lb]
  source     = "../../modules/load_balancers/azurerm_lb_probe"
  lb_probes  = var.lb_probes
  rg_name    = module.rg.names
}

module "lb_rule" {
  depends_on = [module.rg, module.pips, module.subnet, module.vnet, module.lb, module.lb_bpool]
  source     = "../../modules/load_balancers/azurerm_lb_rule"
  lb_rules   = var.lb_rules
  rg_name    = module.rg.names
  probe_id   = module.lb_hprobe.lb_probe_ids
}

module "nic_lbbpool_associ" {
  depends_on       = [module.rg, module.nics, module.lb, module.lb_bpool]
  source           = "../../modules/load_balancers/azurerm_network_interface_backend_address_pool_association"
  nic_bpool_associ = var.nic_bpool_associ
  rg_name          = module.rg.names

}

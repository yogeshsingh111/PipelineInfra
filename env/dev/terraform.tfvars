subscription_id = "009fad33-c09c-4841-af38-57dd79870d40"

resource_groups = {
  rg1 = {
    name       = "devstream-rg"
    location   = "westus"
    managed_by = "yogesh"
    tags = {
      environment = "dev"
      project     = "devstreamsolutions"
      owner       = "yogi"
      phase       = "initial"
    }
  }
}

stgaccount = {
  stgacc1 = {
    name                     = "stgdevstream"
    rg_key                   = "rg1"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      project     = "devstreamsolutions"
      owner       = "yogesh"
      phase       = "initial"
    }
    access_tier = "Hot"
  }
}

vnets = {
  rg1_vnet1 = {
    name          = "vnet1"
    rg_key        = "rg1"
    location      = "westus"
    address_space = ["192.168.0.0/16"]
  }
}

subnets = {
  frontend = {
    subnet_name          = "akkc-frontend-subnet01"
    rg_key               = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["192.168.0.0/24"]
  }
  backend = {
    subnet_name          = "akkc-backend-subnet01"
    rg_key               = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["192.168.1.0/24"]
  }
  bastion = {
    subnet_name          = "AzureBastionSubnet"
    rg_key               = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["192.168.2.0/24"]
  }
  appgw = {
    subnet_name          = "appgw-subnet"
    rg_key               = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["192.168.3.0/24"]
  }
  lb_subnet = {
    subnet_name          = "lb_subnet"
    rg_key               = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["192.168.4.0/24"]
  }
}

pips = {
  lbpip = {
    pip_name          = "lb-pip01"
    location          = "westus"
    rg_key            = "rg1"
    allocation_method = "Static"
    sku               = "Standard"
    tags = {
      environment = "dev"
      project     = "devstreamsolutions"
      owner       = "yogesh"
    }
  }
  bastionpip = {
    pip_name          = "bastion-pip01"
    location          = "westus"
    rg_key            = "rg1"
    allocation_method = "Static"
    sku               = "Standard"
    tags = {
      environment = "dev"
      project     = "devstreamsolutions"
      owner       = "yogesh"
      phase       = "initial"
    }
  }
}

nics = {
  nic1 = {
    nic_name    = "vm1-nic"
    rg_key      = "rg1"
    location    = "westus"
    subnet_name = "devstream-frontend-subnet01"
    vnet_name   = "vnet1"
    ip_configuration = [{
      name                          = "ipconfig01"
      private_ip_address_allocation = "Dynamic"
    }]
    tags = {
      environment = "dev"
      project     = "devstreamsolutions"
      owner       = "yogi"
    }
  }

  nic2 = {
    nic_name    = "vm2-nic"
    rg_key      = "rg1"
    location    = "westus"
    subnet_name = "devstream-backend-subnet01"
    vnet_name   = "vnet1"
    ip_configuration = [{
      name                          = "ipconfig02"
      private_ip_address_allocation = "Dynamic"
    }]
    tags = {
      environment = "dev"
      project     = "devstreamsolutions"
      owner       = "yogesh"
    }
  }
}

nsg = {
  nsg1 = {
    nsg_name            = "nsg1"
    location            = "westus"
    resource_group_name = ""
    rg_key              = "rg1"
    tags = {
      environment = "dev"
      project     = "devstreamsolutions"
      owner       = "yogesh"
    }
    security_rule = [
      {
        name              = "allow_ssh"
        priority          = 100
        direction         = "Inbound"
        access            = "Allow"
        protocol          = "Tcp"
        source_port_range = "*" # keep one side as single (usually *)
        # destination_port_range  = "22"
        #source_port_ranges      = ["80", "443"]            # Source ports
        destination_port_ranges    = ["8080", "8443", "9000"] # Destination ports
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow SSH inbound traffic"
      },
      {
        name                       = "deny_all_outbound"
        priority                   = 200
        direction                  = "Outbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Deny all outbound traffic"
      },
      {
        name                       = "allow_ssh1"
        priority                   = 103
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow SSH inbound traffic"
      }
    ]
  }
}

nic_nsg_map = {
  association1 = {
    nic_key = "nic1"
    nsg_key = "nsg1"
  }
  association2 = {
    nic_key = "nic2"
    nsg_key = "nsg1"
  }
}

key_vaults = {
  kv-dev = {
    name                            = "assignment-devstream"
    location                        = "westus"
    rg_key                          = "rg1"
    sku_name                        = "standard"
    soft_delete_retention_days      = 7
    purge_protection_enabled        = true
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = false
    rbac_authorization_enabled      = false
    public_network_access_enabled   = true
    tags = {
      environment = "production"
      owner       = "team-prod"
    }

    access_policies = [
      {
        key_permissions         = ["Get", "List", "Create", "Delete"]
        secret_permissions      = ["Get", "Set", "List", "Delete"]
        certificate_permissions = ["Get", "Import", "Delete"]
        storage_permissions     = ["Get"]
      }
    ]
  }
}

key_vault_secrets = {
  "sc1" = {
    kv_secret = "vm1-username"
    kv_value  = "devstreamadmin"
    rg_key    = "rg1"
    kv_name   = "assignment-kvdevstream"
  }
  "sc2" = {
    kv_secret = "vm1-password"
    kv_value  = "Devops#4321!"
    rg_key    = "rg1"
    kv_name   = "assignment-kvdevstream"
  }
  "sc5" = {
    kv_secret = "vm2-username"
    kv_value  = "akkcadmin"
    rg_key    = "rg1"
    kv_name   = "assignment-kvdevstream"
  }
  "sc6" = {
    kv_secret = "vm2-password"
    kv_value  = "Devops#4321!"
    rg_key    = "rg1"
    kv_name   = "assignment-kvdevstream"
  }
  "sc3" = {
    kv_secret = "sql-username"
    kv_value  = "akkcsqladmin"
    rg_key    = "rg1"
    kv_name   = "assignment-kvdevstream"
  }
  "sc4" = {
    kv_secret = "sql-password"
    kv_value  = "Devops#4321!"
    rg_key    = "rg1"
    kv_name   = "assignment-kvdevstream"
  }
}

lvm = {
  vm1 = {
    vm_name                         = "linux-vm-01"
    rg_key                          = "rg1"
    location                        = "westus"
    size                            = "Standard_B2s"
    nic_name                        = "vm1-nic"
    kv_name                         = "assignment-kvdevstream"
    username_secret                 = "vm1-username"
    password_secret                 = "vm1-password"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    os_disk = {
      name                 = "linux-vm-01-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    tags = {
      environment = "dev"
      owner       = "team-alpha"
    }
  }
}

wvm = {
  vm1 = {
    rg_key          = "rg1"
    vm_name         = "devstream-wvm"
    kv_name         = "assignment-kvdevstream"
    location        = "westus"
    nic_name        = "vm2-nic"
    size            = "Standard_B1s"
    username_secret = "vm2-username"
    password_secret = "vm2-password"

    os_disk = {
      name                 = "demo-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 128
    }

    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-datacenter"
      version   = "latest"
    }
  }
}

sql_servers = {
  server1 = {
    sqlserver_name    = "devstream-mssqlsrv001"
    rg_key            = "rg1"
    kv_name           = "assignment-kvdevstream"
    location          = "westus"
    version           = "12.0"
    sql_user_secret   = "sql-username"
    sql_pass_secret   = "sql-password"
    connection_policy = "Default"
    identity = {
      type = "SystemAssigned"
    }
    tags = {
      environment = "prod"
      project     = "devstreamsolutions"
      owner       = "yogesh"
      phase       = "final"
    }
  }
}

sql_databases = {
  db1 = {
    name                        = "dev-sqldb011"
    server_name                 = "akkc-mssqlsrv001"
    rg_key                      = "rg1"
    location                    = "westus"
    sku_name                    = "S0"
    max_size_gb                 = 5
    auto_pause_delay_in_minutes = 60
    ledger_enabled              = false
    tags = {
      environment = "dev"
      owner       = "devops"
    }
  }

  db2 = {
    name                        = "dev-sqldb022"
    server_name                 = "devstream-mssqlsrv001"
    rg_key                      = "rg1"
    location                    = "westus"
    sku_name                    = "S0"
    max_size_gb                 = 5
    auto_pause_delay_in_minutes = 60
    ledger_enabled              = false
    tags = {
      environment = "dev"
      owner       = "devops"
    }
  }
}

log_analytics_workspaces = {
  workspace1 = {
    law_name          = "workspace01"
    rg_key            = "rg1"
    location          = "East US"
    sku               = "PerGB2018"
    retention_in_days = 30
  }
  workspace2 = {
    law_name          = "workspace02"
    rg_key            = "rg1"
    location          = "West Europe"
    sku               = "PerGB2018"
    retention_in_days = 60
  }
}

bastions = {
  "bastion1" = {
    bastion_host_name = "devstream-bastion-host"
    location          = "westus"
    rg_key            = "rg1"
    subnet_name       = "AzureBastionSubnet"
    vnet_name         = "vnet1"
    bastion_pip_name  = "bastion-pip01"
  }
}

# aks_clusters = {
#   aks1 = {
#     rg_key       = "rg1"
#     cluster_name = "clusterdev011"
#     location     = "canadacentral"
#     node_count   = 1
#     vm_size      = "Standard_B1s"
#     dns_prefix   = "exampleaks1"
#   }
#   # aks2 = {
#   #   rg_key       = "rg1"
#   #   cluster_name = "clusterdev02"
#   #   location     = "West US"
#   #   node_count   = 2
#   #   vm_size      = "Standard_D2_v2"
#   #   dns_prefix   = "exampleaks2"
#   # }
# }

# acr_instances = {
#   "acr1" = {
#     location      = "East US"
#     sku           = "Premium"
#     rg_key        = "rg1"
#     acr_name      = "akkcacr007"
#     admin_enabled = false
#     georeplications = {
#       "East US" = {
#         location                = "westus"
#         zone_redundancy_enabled = null
#         tags                    = {}
#       }
#     }
#   }
# }
# aks_acr_role_assignments = {
#   "kubelet1" = {
#     rg_key   = "rg1"
#     acr_name = "akkcacr007"
#     aks_name = "clusterdev011"
#   }
# }

load_balancers = {
  "lb1" = {
    lb_name     = "devstreamlb001"
    location    = "westus"
    rg_key      = "rg1"
    lb_pip_name = "lb-pip01"
    subnet_name = "lb_subnet"
    vnet_name   = "vnet1"
    #edge_zone   = "zone1"
    sku      = "Standard"
    sku_tier = "Regional"
    tags = {
      environment = "dev"
      project     = "terraform-demo"
    }
    frontend_ip_configuration = [
      {
        name                          = "fe-ip-1"
        private_ip_address_allocation = "Dynamic"
    }]
  }
}

backend_pools = {
  "bepool1" = {
    lb_name      = "devstreamlb001"
    lb_bpoolname = "lbbpool01"
    rg_key       = "rg1"
  }
}

lb_probes = {
  "lbprobe1" = {
    hpb_name            = "hprobe01"
    lb_name             = "devstreamlb001"
    rg_key              = "rg1"
    port                = 80
    protocol            = "Tcp"
    interval_in_seconds = 5
  }
}

lb_rules = {
  "lbr1" = {
    lb_name                        = "devstreamlb001"
    rg_key                         = "rg1"
    probe_key                      = "lbprobe1"
    lb_bpoolname                   = "lbbpool01"
    lbr_name                       = "lbrule1"
    frontend_ip_configuration_name = "fe-ip-1"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    idle_timeout_in_minutes        = 4
  }
}



nic_bpool_associ = {
  association1 = {
    rg_key                    = "rg1"
    nic_ip_configuration_name = "ipconfig01"
    nic_name                  = "vm1-nic"
    lb_name                   = "devstreamlb001"
    lb_bpoolname              = "lbbpool01"
  }
  association2 = {
    rg_key                    = "rg1"
    nic_ip_configuration_name = "ipconfig02"
    nic_name                  = "vm2-nic"
    lb_name                   = "devstreamlb001"
    lb_bpoolname              = "lbbpool01"
  }

}

module "general_module" {
  source="./modules/general"
  resource_group_name=local.resource_group_name
  location=local.location
}

module "networking_module" {
  source="./modules/networking"
  resource_group_name=local.resource_group_name 
  location=local.location
  virtual_network_name = "CIBI-LMnetworks"
  virtual_network_address_space = "10.0.0.0/16"
  subnet_name = "CIBI-LMsubnet"
  subnet_address_prefix = "10.0.0.0/24"
  network-security_group_name="lm-nsg"
  network_security_group_rules=[{
    id=1,
    priority="200"
    network_security_group_name="lm-nsg"
    destination_port_range="162"
    access="Allow"
  },
  {
    id=2,
    priority="300"
    network_security_group_name="lm-nsg"
    destination_port_range="514"
    access="Allow"
  },
  {
    id=3,
    priority="400"
    network_security_group_name="lm-nsg"
    destination_port_range="2055"
    access="Allow"
  },
  {
    id=4,
    priority="600"
    network_security_group_name="lm-nsg"
    destination_port_range="6343"
    access="Allow"
  },
  {
    id=4,
    priority="800"
    network_security_group_name="lm-nsg"
    protocol = "Tcp"
    destination_port_range="7214"
    access="Allow"
  }
  ]
  depends_on = [ 
    module.general_module
   ]
}

# Create an app data source for manual (outside of terraform) keyvault & secret
data "azurerm_key_vault" "lmvault2025" {
  name                = "lm-vault2025"
  resource_group_name = "CIBI-Security_KV"
}
data "azurerm_key_vault_secret" "lm-vmpassword" {
  name         = "lm-vmpassword"
  key_vault_id = data.azurerm_key_vault.lmvault2025.id
}

module "compute_module" {
  source = "./modules/compute"
  resource_group_name=local.resource_group_name 
  location=local.location
  size = "Standard_D1s_v3"
  network_interface_name = "lm-interface"
  subnet_id = module.networking_module.subnets.id
  virtual_machine_name = "SBIMD-LOGIC01"
  admin_username = "LMadmin"
  admin_password = data.azurerm_key_vault_secret.lm-vmpassword.value
  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  depends_on = [ 
    module.networking_module
   ]
}
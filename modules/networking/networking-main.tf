# Creation of a virtual network
resource "azurerm_virtual_network" "CIBI-LMnetworks" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.virtual_network_address_space]
}

# Creation of Subnets
resource "azurerm_subnet" "CIBI-LMsubnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnet_address_prefix]
  depends_on = [
    azurerm_virtual_network.CIBI-LMnetworks
  ]
}

# Creation of Bastion Subnets
resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.10.0/24"]
  depends_on = [
    azurerm_virtual_network.CIBI-LMnetworks
  ]
}

#Creation of a Bastion Public IP address
resource "azurerm_public_ip" "lm-bastionip" {
  name                = "lm-bastionip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Creation of a Bastion host
resource "azurerm_bastion_host" "lm-bastion" {
  name                = "lm-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.lm-bastionip.id
  }
}

#Create an NSG object
resource "azurerm_network_security_group" "lm-nsg" {
  name                = "lm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

depends_on = [
    azurerm_virtual_network.CIBI-LMnetworks
  ]
}

resource "azurerm_subnet_network_security_group_association" "lmnsg-link" {  
  subnet_id                 = azurerm_subnet.CIBI-LMsubnet.id
  network_security_group_id = azurerm_network_security_group.lm-nsg.id

  depends_on = [
    azurerm_virtual_network.CIBI-LMnetworks,
    azurerm_network_security_group.lm-nsg
  ]
}

resource "azurerm_network_security_rule" "lm-nsgrules" {
  for_each = { for idx, rule in var.network_security_group_rules : idx => rule }
    name                       = "${each.value.access}-${each.value.destination_port_range}"
    priority                   = each.value.priority
    direction                  = "Inbound"
    access                     = each.value.access
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = each.value.destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.lm-nsg.name
      depends_on = [
    azurerm_network_security_group.lm-nsg
  ]
}
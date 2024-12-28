output "virtual_network" {
  value = azurerm_virtual_network.CIBI-LMnetworks
}

output "subnets" {
  value = azurerm_subnet.CIBI-LMsubnet
}
variable "resource_group_name" {
    type=string
    description="This defines the name of the resource group"
}

variable "location" {
    type=string
    description="This defines the location of the virtual network"
}

variable "virtual_network_name" {
    type=string
    description="This defines the name of the virtual network"
}

variable "virtual_network_address_space" {
    type=string
    description="This defines the address of the virtual network"
}

variable "subnet_name" {
    type=string
    description="This defines the subnet within the virtual network"
}

variable "subnet_address_prefix" {
    type=string
    description="This defines the subnet adress prefix  within the virtual network"
}

variable "network-security_group_name" {
    type=string
    description="This defines the names of the network security groups"
}

variable "network_security_group_rules" {
    type=list
    description="This defines the network secuirty group rules"
}
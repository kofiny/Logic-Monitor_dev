variable network_interface_name {
    type = string
    description = "This defines the network interface name"
}

variable "resource_group_name" {
    type=string
    description="This defines the name of the resource group"
}

variable "location" {
    type=string
    description="This defines the location of the virtual network"
}

variable "subnet_id" {
    type=string
    description="This defines the subnet id"
}

variable "private_ip_address_allocation" {
    type=string
    description="This defines the private ip address allocation"
    default = "Dynamic"
}

variable "public_ip_name" {
    type=string
    description="This defines the public ip address"
    default = "default-ip"
}

variable "public_ip_required" {
    type=bool
    description="This defines the public ip address"
    default = false
}

variable "virtual_machine_name" {
    type=string
    description="This defines the virtual machine name"
}

variable "admin_username" {
    type=string
    description="This defines the admin username"
}

variable "admin_password" {
    type=string
    description="This defines the admin password"
}

variable "source_image_reference" {
    type=map
    description="This defines the source image reference for the Windows Database server"
}

variable "size" {
    type=string
    description="This defines the size of the virtual machine"
}


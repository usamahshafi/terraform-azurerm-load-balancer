# Fetch the existing Virtual Network (VNet)
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group
}

# Fetch the existing Virtual Machines (VMs) in the VNet
data "azurerm_network_interface" "vm_nics" {
  for_each            = var.vm_names
  name                = each.value
  resource_group_name = var.vm_resource_group
}

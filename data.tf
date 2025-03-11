# Fetch the existing Virtual Machines (VMs) in the VNet
data "azurerm_network_interface" "vm_nics" {
  for_each            = var.vm_names
  name                = each.value
  resource_group_name = var.vm_resource_group
}

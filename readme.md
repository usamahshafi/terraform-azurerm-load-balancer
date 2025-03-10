# **Azure Load Balancer Terraform Module**

This Terraform module deploys an **Azure Load Balancer (LB)** with support for:
- **Public or Internal Load Balancer** with optional **Public IP**
- **Backend Pool** to register Virtual Machines dynamically
- **Health Probes** for monitoring
- **Load Balancer Rules** for traffic distribution

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.backend_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_probe.health_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_network_interface_backend_address_pool_association.vm_backend_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_public_ip.lb_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azurerm-resource-group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_network_interface.vm_nics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_interface) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines the allocation method for the public IP address. Possible values are 'Static' or 'Dynamic'. | `string` | `"Static"` | no |
| <a name="input_lb_rule_backend_port"></a> [lb\_rule\_backend\_port](#input\_lb\_rule\_backend\_port) | Backend port for LB rule | `number` | `80` | no |
| <a name="input_lb_rule_frontend_port"></a> [lb\_rule\_frontend\_port](#input\_lb\_rule\_frontend\_port) | Frontend port for LB rule | `number` | `80` | no |
| <a name="input_lb_rule_protocol"></a> [lb\_rule\_protocol](#input\_lb\_rule\_protocol) | Protocol for LB rule | `string` | `"Tcp"` | no |
| <a name="input_lb_sku"></a> [lb\_sku](#input\_lb\_sku) | SKU for Load Balancer | `string` | `"Standard"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region | `string` | `"East US"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for resource names | `string` | `"test"` | no |
| <a name="input_probe_port"></a> [probe\_port](#input\_probe\_port) | Port for health probe | `number` | `80` | no |
| <a name="input_probe_protocol"></a> [probe\_protocol](#input\_probe\_protocol) | Protocol for health probe | `string` | `"Tcp"` | no |
| <a name="input_public_ip_enabled"></a> [public\_ip\_enabled](#input\_public\_ip\_enabled) | Enable public IP (true for external LB, false for internal LB) | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | `{}` | no |
| <a name="input_vm_names"></a> [vm\_names](#input\_vm\_names) | A map of VM names to be added to the backend pool | `map(string)` | n/a | yes |
| <a name="input_vm_resource_group"></a> [vm\_resource\_group](#input\_vm\_resource\_group) | The resource group where the VMs are located | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the existing Virtual Network | `string` | n/a | yes |
| <a name="input_vnet_resource_group"></a> [vnet\_resource\_group](#input\_vnet\_resource\_group) | The resource group where the VNet is located | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_pool_id"></a> [backend\_pool\_id](#output\_backend\_pool\_id) | The ID of the Load Balancer backend address pool |
| <a name="output_health_probe_id"></a> [health\_probe\_id](#output\_health\_probe\_id) | The ID of the Load Balancer health probe |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | The ID of the Load Balancer |
| <a name="output_lb_name"></a> [lb\_name](#output\_lb\_name) | The name of the Load Balancer |
| <a name="output_lb_private_ip"></a> [lb\_private\_ip](#output\_lb\_private\_ip) | The private IP address of the Load Balancer (if internal) |
| <a name="output_lb_public_ip"></a> [lb\_public\_ip](#output\_lb\_public\_ip) | The public IP address of the Load Balancer (if enabled) |
| <a name="output_lb_rule_id"></a> [lb\_rule\_id](#output\_lb\_rule\_id) | The ID of the Load Balancer rule |

---

## **Example Usage**
```hcl
module "lb" {
  source              = "path/to/this/module"
  location            = "East US"
  lb_sku              = "Standard"
  public_ip_enabled   = true
  prefix              = "my-lb"
  vnet_name           = "my-vnet"
  vnet_resource_group = "my-network-rg"
  vm_resource_group   = "my-vm-rg"

  vm_names = {
    "vm1" = "vm1-nic"
    "vm2" = "vm2-nic"
  }

  tags = {
    environment = "prod"
    owner       = "team"
  }
}

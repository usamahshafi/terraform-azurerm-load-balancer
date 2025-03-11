# **Azure Load Balancer Terraform Module**

This Terraform module deploys an **Azure Load Balancer (LB)** with support for:
- **Public or Internal Load Balancer** with optional **Public IP**
- **Backend Pool** to register Virtual Machines dynamically
- **Health Probes** for monitoring
- **Load Balancer Rules** for traffic distribution
- **Inbound NAT Rules** for secure communication
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
| [azurerm_lb_nat_rule.nat_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_probe.health_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.lb_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_network_interface_backend_address_pool_association.vm_backend_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_network_interface_nat_rule_association.nat_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_nat_rule_association) | resource |
| [azurerm_public_ip.lb_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azurerm-resource-group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_network_interface.vm_nics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_interface) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines the allocation method for the public IP address. Possible values are 'Static' or 'Dynamic'. | `string` | `"Static"` | no |
| <a name="input_lb_nat_rules"></a> [lb\_nat\_rules](#input\_lb\_nat\_rules) | List of Load Balancer NAT rules | <pre>map(object({<br/>    name                          = string<br/>    protocol                      = string<br/>    frontend_port                 = number<br/>    backend_port                  = number<br/>    target_vm                     = string<br/>  }))</pre> | `{}` | no |
| <a name="input_lb_rules"></a> [lb\_rules](#input\_lb\_rules) | List of Load Balancer rules | <pre>map(object({<br/>    name           = string<br/>    protocol       = string<br/>    frontend_port  = number<br/>    backend_port   = number<br/>  }))</pre> | `{}` | no |
| <a name="input_lb_sku"></a> [lb\_sku](#input\_lb\_sku) | SKU for Load Balancer | `string` | `"Standard"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region | `string` | `"East US"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for resource names | `string` | `"test"` | no |
| <a name="input_probe_port"></a> [probe\_port](#input\_probe\_port) | Port for health probe | `number` | `80` | no |
| <a name="input_probe_protocol"></a> [probe\_protocol](#input\_probe\_protocol) | Protocol for health probe | `string` | `"Tcp"` | no |
| <a name="input_public_ip_enabled"></a> [public\_ip\_enabled](#input\_public\_ip\_enabled) | Enable public IP (true for external LB, false for internal LB) | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | `{}` | no |
| <a name="input_vm_names"></a> [vm\_names](#input\_vm\_names) | A map of VM names to be added to the backend pool | `map(string)` | n/a | yes |
| <a name="input_vm_resource_group"></a> [vm\_resource\_group](#input\_vm\_resource\_group) | The resource group where the VMs are located | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_pool_id"></a> [backend\_pool\_id](#output\_backend\_pool\_id) | The ID of the Load Balancer backend address pool |
| <a name="output_health_probe_id"></a> [health\_probe\_id](#output\_health\_probe\_id) | The ID of the Load Balancer health probe |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | The ID of the Load Balancer |
| <a name="output_lb_name"></a> [lb\_name](#output\_lb\_name) | The name of the Load Balancer |
| <a name="output_lb_nat_rule_ids"></a> [lb\_nat\_rule\_ids](#output\_lb\_nat\_rule\_ids) | The IDs of the Load Balancer NAT rules |
| <a name="output_lb_private_ip"></a> [lb\_private\_ip](#output\_lb\_private\_ip) | The private IP address of the Load Balancer (if internal) |
| <a name="output_lb_public_ip"></a> [lb\_public\_ip](#output\_lb\_public\_ip) | The public IP address of the Load Balancer (if enabled) |
| <a name="output_lb_rule_ids"></a> [lb\_rule\_ids](#output\_lb\_rule\_ids) | The IDs of the Load Balancer rules |

---

## **Example Usage**
```hcl
module "load_balancer" {
  source = "../"  

  prefix             = "test"
  location           = "East US"
  vm_resource_group  = "terraform-backend"
  lb_sku            = "Standard"
  public_ip_enabled = true
  allocation_method = "Static"

  vm_names = {
    "vm1" = "test-vm23" // Value is NIC name
  }

  lb_rules = {
    rule1 = {
      name          = "http-rule"
      protocol      = "Tcp"
      frontend_port = 80
      backend_port  = 80
    }
    rule2 = {
      name          = "https-rule"
      protocol      = "Tcp"
      frontend_port = 443
      backend_port  = 443
    }
  }

  lb_nat_rules = {
    nat1 = {
      name          = "ssh-rule"
      protocol      = "Tcp"
      frontend_port = 22
      backend_port  = 22
      target_vm     = "vm1"
    }
  }

  probe_protocol = "Tcp"
  probe_port     = 80

  tags = {
    environment = "dev"
    project     = "terraform-lb"
  }
}
```hcl
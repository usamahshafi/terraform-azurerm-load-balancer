resource "azurerm_resource_group" "azurerm-resource-group" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "lb_pip" {
  count               = var.public_ip_enabled ? 1 : 0
  name                = "${local.lb_name}-public-ip"
  resource_group_name = azurerm_resource_group.azurerm-resource-group.name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_lb" "main" {
  name                = local.lb_name
  location            = var.location
  resource_group_name = azurerm_resource_group.azurerm-resource-group.name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = local.frontend_ip_config_name
    public_ip_address_id = var.public_ip_enabled ? azurerm_public_ip.lb_pip[0].id : null
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.main.id
  name            = "${local.lb_name}-backend-pool"
}

resource "azurerm_network_interface_backend_address_pool_association" "vm_backend_association" {
  for_each                  = var.vm_names
  network_interface_id      = data.azurerm_network_interface.vm_nics[each.key].id
  ip_configuration_name     = "internal"
  backend_address_pool_id   = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_lb_probe" "health_probe" {
  loadbalancer_id = azurerm_lb.main.id
  name            = "${local.lb_name}-health-probe"
  protocol        = var.probe_protocol
  port            = var.probe_port
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "${local.lb_name}-rule"
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port
  frontend_ip_configuration_name = local.frontend_ip_config_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.health_probe.id
}
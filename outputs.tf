output "lb_id" {
  description = "The ID of the Load Balancer"
  value       = azurerm_lb.main.id
}

output "lb_name" {
  description = "The name of the Load Balancer"
  value       = azurerm_lb.main.name
}

output "lb_private_ip" {
  description = "The private IP address of the Load Balancer (if internal)"
  value       = one(azurerm_lb.main.frontend_ip_configuration[*].private_ip_address)
}

output "lb_public_ip" {
  description = "The public IP address of the Load Balancer (if enabled)"
  value       = var.public_ip_enabled ? azurerm_public_ip.lb_pip[0].ip_address : null
}

output "backend_pool_id" {
  description = "The ID of the Load Balancer backend address pool"
  value       = azurerm_lb_backend_address_pool.backend_pool.id
}

output "health_probe_id" {
  description = "The ID of the Load Balancer health probe"
  value       = azurerm_lb_probe.health_probe.id
}

output "lb_rule_ids" {
  description = "The IDs of the Load Balancer rules"
  value       = { for k, v in azurerm_lb_rule.lb_rules : k => v.id }
}

output "lb_nat_rule_ids" {
  description = "The IDs of the Load Balancer NAT rules"
  value       = { for k, v in azurerm_lb_nat_rule.nat_rules : k => v.id }
}


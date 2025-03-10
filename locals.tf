locals {
  prefix               = var.prefix
  resource_group_name  = "${local.prefix}-rg"
  lb_name              = "${local.prefix}-lb"
  frontend_ip_config_name = "frontend"
}

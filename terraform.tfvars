vm_resource_group   = "terraform-backend"

vm_names = {
  "vm1" = "test-vm23"
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
    name                          = "rdp-rule"
    protocol                      = "Tcp"
    frontend_port                 = 3389
    backend_port                  = 3389
    target_vm                     = "vm1"
  }
}

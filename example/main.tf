terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "terraform-backend"  
  #   storage_account_name = "backendstorage121"                      
  #   container_name       = "tfstate"                       
  #   key                  = "test.terraform.tfstate"        
  # }

  required_version = ">=1.9.0"
}

provider "azurerm" {
    features {
      
    }
  
}

# Commented to delete resource

# module "load_balancer" {
#   source = "../"  # Path to your module

#   # General Configurations
#   prefix             = "test"
#   location           = "East US"
#   vm_resource_group  = "terraform-backend"
#   lb_sku            = "Standard"
#   public_ip_enabled = true
#   allocation_method = "Static"

#   # VM Definitions (Backend Pool)
#   vm_names = {
#     "vm1" = "test-vm23" // Value is NIC name
#   }

#   # Load Balancer Rules
#   lb_rules = {
#     rule1 = {
#       name          = "http-rule"
#       protocol      = "Tcp"
#       frontend_port = 80
#       backend_port  = 80
#     }
#     rule2 = {
#       name          = "https-rule"
#       protocol      = "Tcp"
#       frontend_port = 443
#       backend_port  = 443
#     }
#   }

#   # NAT Rules (Mapping to Specific VMs)
#   lb_nat_rules = {
#     nat1 = {
#       name          = "ssh-rule"
#       protocol      = "Tcp"
#       frontend_port = 22
#       backend_port  = 22
#       target_vm     = "vm1"
#     }
#   }

#   # Health Probe Configuration
#   probe_protocol = "Tcp"
#   probe_port     = 80

#   # Tags
#   tags = {
#     environment = "dev"
#     project     = "terraform-lb"
#   }
# }

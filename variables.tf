variable "prefix" {
    description = "Prefix for resource names"
    type = string
    default = "test"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
  validation {
    condition     = contains(["East US", "East US 2", "Central US"], var.location)
    error_message = "Invalid Azure region. Accepted regions are: East US and East US 2."
  }
}

 
variable "public_ip_enabled" {
  description = "Enable public IP (true for external LB, false for internal LB)"
  type        = bool
  default     = true
}
 
variable "allocation_method" {
  description = "Defines the allocation method for the public IP address. Possible values are 'Static' or 'Dynamic'."
  type        = string
  default     = "Static"
  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "Possible values for allocation_method are 'Static' or 'Dynamic'."
  }
}

variable "lb_sku" {
  description = "SKU for Load Balancer"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.lb_sku)
    error_message = "The lb_sku must be either 'Basic' or 'Standard'."
  }
}

variable "probe_protocol" {
  description = "Protocol for health probe"
  type        = string
  default     = "Tcp"
}

variable "probe_port" {
  description = "Port for health probe"
  type        = number
  default     = 80
}

variable "lb_rules" {
  description = "List of Load Balancer rules"
  type = map(object({
    name           = string
    protocol       = string
    frontend_port  = number
    backend_port   = number
  }))
  default = {}
}

variable "lb_nat_rules" {
  description = "List of Load Balancer NAT rules"
  type = map(object({
    name                          = string
    protocol                      = string
    frontend_port                 = number
    backend_port                  = number
    target_vm                     = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "vm_names" {
  description = "A map of VM names to be added to the backend pool"
  type        = map(string)
}

variable "vm_resource_group" {
  description = "The resource group where the VMs are located"
  type        = string
}

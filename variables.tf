variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "name" {
  description = "Linux ScaleSet name"
  type        = string
  default     = "linux-scaleset"
}

variable "instances" {
  description = "Number of instances."
  type        = number
  default     = 1
}

variable "subnet_id" {
  description = "Subnet id for Scale Set."
  type        = string
}

variable "load_balancer_backend_address_pool_ids" {
  description = "Load balancer backend address pool ids."
  type        = list(string)
  default     = null
}

variable "enable_health_probe_id" {
  description = "Enables health check probe id for Scale Set"
  type        = bool
  default     = false
}

variable "health_probe_id" {
  description = "Health probe id. IE: azurerm_lb_probe."
  type        = string
  default     = null
}

variable "custom_data" {
  description = "custom_data."
  type        = string
  default     = "# noop"
}

variable "public_key" {
  description = "SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "source_image_reference" {
  description = "VM image"
  type = map
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "enable_public_ip_address" {
  description = "VM image"
  type        = bool
  default     = true
}

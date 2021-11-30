data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  sku                 = "Standard_B1ls" # "Standard_F2"
  instances           = var.instances
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.public_key)
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.name}-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id

      dynamic "public_ip_address" {
        for_each = var.enable_public_ip_address ? [1] : []
        content {
          name = "pip"
        }
      }

      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
    }
  }

  custom_data = base64encode(var.custom_data)

  # For quicker testing. Automatically updates and replaces instances as fast as possible.
  # Conditional for a Stack Set is rename. Need to turn off Rolling updates and the Health Check in that case.
  upgrade_mode = var.enable_health_probe_id ? "Rolling" : "Manual"
  dynamic "rolling_upgrade_policy" {
    for_each = var.enable_health_probe_id ? [1] : []
    content {
      max_batch_instance_percent = 100
      max_unhealthy_instance_percent = 100
      max_unhealthy_upgraded_instance_percent = 100
      pause_time_between_batches = "PT0S"
    }
  }
  health_probe_id = var.enable_health_probe_id ? var.health_probe_id : null
}

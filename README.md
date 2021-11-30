# Terraform Azure Linux Virtual Machine Scale Set

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

Simple example with:

* [azurerm_linux_virtual_machine_scale_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set)

## Add to Terrafile

```ruby
mod "linux-virtual-machine-scale-set", source: "boltops-tools/linux-virtual-machine-scale-set/azure"
```

## Import Example

    terraspace bundle # installs to vendor/modules/linux-virtual-machine-scale-set
    terraspace bundle example linux-virtual-machine-scale-set linux_scaleset # imports to app/stacks/linux_scaleset

## Configure Tfvars

    terraspace seed linux_scaleset # creates starter app/stacks/linux_scaleset/tfvars/dev.tfvars

## Deploy

    terraspace up linux_scaleset

## Clean Up

    terraspace down linux_scaleset


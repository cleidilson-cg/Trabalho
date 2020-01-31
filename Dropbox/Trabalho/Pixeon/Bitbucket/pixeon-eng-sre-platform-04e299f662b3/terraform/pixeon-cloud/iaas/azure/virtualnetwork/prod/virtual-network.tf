# Configure the Azure Provider
provider "azurerm" { }

# Create a resource group
resource "azurerm_resource_group" "pixeon_cloud" {
  name     = "${var.stack_name}-${var.stack_env}"
  location = "${var.stack_location}"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "pixeon_network" {
  name                = "${var.stack_name}-${var.stack_env}"
  address_space       = ["${var.virtual_network_cidr}"]
  location            = "${azurerm_resource_group.pixeon_cloud.location}"
  resource_group_name = "${azurerm_resource_group.pixeon_cloud.name}"
}

resource "azurerm_subnet" "private" {
  name                 = "${var.stack_name}-${var.stack_env}-private"
  resource_group_name  = "${azurerm_resource_group.pixeon_cloud.name}"
  virtual_network_name = "${azurerm_virtual_network.pixeon_network.name}"
  route_table_id       = "${azurerm_route_table.pixeon_cloud_route_table.id}"
  address_prefix       = "${var.private_subnet_cidr}"
}


resource "azurerm_subnet" "public" {
  name                 = "${var.stack_name}-${var.stack_env}-public"
  resource_group_name  = "${azurerm_resource_group.pixeon_cloud.name}"
  virtual_network_name = "${azurerm_virtual_network.pixeon_network.name}"
  address_prefix       = "${var.public_subnet_cidr}"
}


resource "azurerm_route_table" "pixeon_cloud_route_table" {
  name                = "${var.stack_name}-${var.stack_env}-private"
  location            = "${azurerm_resource_group.pixeon_cloud.location}"
  resource_group_name = "${azurerm_resource_group.pixeon_cloud.name}"
  // subnets             = "${azurerm_virtual_network.pixeon_network.subnet[0]}"
  disable_bgp_route_propagation = false

  route {
    name           = "to-pixeon-cloud-aws-sa"
    address_prefix = "10.224.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.227.16.4"
  }

  route {
    name           = "to-pixeon-scs"
    address_prefix = "10.11.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.227.16.4"
  }

  route {
    name           = "to-pixeon-ssa"
    address_prefix = "10.71.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.227.16.4"
  }

  route {
    name           = "to-pixeon-fln"
    address_prefix = "10.48.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.227.16.4"
  }

  route {
    name           = "to-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  route {
    name           = "to-pixeon-cloud-prod-public"
    address_prefix = "10.227.0.0/20"
    next_hop_type  = "VnetLocal"
  }

  route {
    name           = "to-pixeon-cloud-prod-private"
    address_prefix = "10.227.16.0/20"
    next_hop_type  = "VnetLocal"
  }


  tags {
    Name          = "${var.stack_name}-${var.stack_env}"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}



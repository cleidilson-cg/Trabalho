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
    name           = "to-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  tags {
    Name          = "${var.stack_name}-${var.stack_env}"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}



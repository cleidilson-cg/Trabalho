// Private default Security Groups

resource "azurerm_resource_group" "network_security_groups_defaults" {
  name     = "${var.stack_name}-${var.stack_env}"
  location = "${var.stack_location}"
}

resource "azurerm_network_security_group" "pixeon_cloud_private" {
  name                = "${var.stack_name}-${var.stack_env}-private"
  location            = "${azurerm_resource_group.network_security_groups_defaults.location}"
  resource_group_name = "${azurerm_resource_group.network_security_groups_defaults.name}"
}

resource "azurerm_network_security_rule" "pixeon_cloud_private_inbound" {
  name                        = "${var.stack_name}-${var.stack_env}-private-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.network_security_groups_defaults.name}"
  network_security_group_name = "${azurerm_network_security_group.pixeon_cloud_private.name}"
}

resource "azurerm_network_security_rule" "pixeon_cloud_allow_local_inbound" {
  name                        = "${var.stack_name}-${var.stack_env}-private-allow-inbound"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.227.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.network_security_groups_defaults.name}"
  network_security_group_name = "${azurerm_network_security_group.pixeon_cloud_private.name}"
}


resource "azurerm_network_security_rule" "pixeon_cloud_private_outbound" {
  name                        = "${var.stack_name}-${var.stack_env}-private-outbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.network_security_groups_defaults.name}"
  network_security_group_name = "${azurerm_network_security_group.pixeon_cloud_private.name}"
}
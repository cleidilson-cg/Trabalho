resource "azurerm_resource_group" "app_security_group" {
  name     = "pixeon-firewall"
  location = "${var.stack_location}"
}

resource "azurerm_application_security_group" "app_security_group" {
  name                = "pixeon-cloud-firewall"
  location            = "${azurerm_resource_group.app_security_group.location}"
  resource_group_name = "pixeon-cloud-firewall"
  tags {
    "Env" = "${var.stack_env}"
    "Squad" = "sre"
    "Stack" = "${var.stack_name}"
  }
}
data "azurerm_public_ip" "vm1_server_pip" {
  name                = azurerm_public_ip.vm1_server_pip.name
  resource_group_name = azurerm_resource_group.example.name
}

output "public_ip_address_VM1" {
  value = data.azurerm_public_ip.vm1_server_pip.ip_address
}

data "azurerm_public_ip" "vm2_server_pip" {
  name                = azurerm_public_ip.vm2_server_pip.name
  resource_group_name = azurerm_resource_group.example.name
}

output "public_ip_address_VM2" {
  value = data.azurerm_public_ip.vm2_server_pip.ip_address
}

// NAT GW Public IP
data "azurerm_public_ip" "nat_gw_pip" {
  name                = azurerm_public_ip.nat_gw_pip.name
  resource_group_name = azurerm_resource_group.example.name
}

output "public_ip_address_NATGW-PIP" {
  value = data.azurerm_public_ip.nat_gw_pip.ip_address
}

data "azurerm_nat_gateway" "example" {
  name                = azurerm_nat_gateway.example.name
  resource_group_name = azurerm_resource_group.example.name
}

output "nat_gw_name" {
    value = data.azurerm_nat_gateway.example.name
}
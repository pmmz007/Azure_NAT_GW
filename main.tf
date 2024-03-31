// resource group
resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
  tags = {
    environment = var.environment
  }
}

// virtaul network
resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = [var.address_space]

  tags = {
    environment = var.environment
  }
}

// subnets
// private-subnet
resource "azurerm_subnet" "private-subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.private_subnet_address_prefixes]
}

// NAT Gateway
resource "azurerm_nat_gateway" "example" {
  name                    = var.nat_gw_name
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
#   sku_name                = var.nat_sku_name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes

}
// public ip address of NATGateway
resource "azurerm_public_ip" "nat_gw_pip" {
  name                = var.nat_gw_pip_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku_type
  tags = {
    environment = var.environment
  }
}

// NAT GW with public ip association
resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.example.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pip.id
}

// NAT GW with subnet association
resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = azurerm_subnet.private-subnet.id
  nat_gateway_id = azurerm_nat_gateway.example.id
}

// public ip addresses
// vm1 server public ip addresses
resource "azurerm_public_ip" "vm1_server_pip" {
  name                = var.vm1_server_public_ip_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = var.vm1_server_allocation_method
  sku = var.pip_sku_type
  tags = {
    environment = var.environment
  }
}

// vm2 server public ip address
resource "azurerm_public_ip" "vm2_server_pip" {
  name                = var.vm2_server_public_ip_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = var.vm2_server_allocation_method
  sku = var.pip_sku_type
  tags = {
    environment = var.environment
  }
}

//Security group
// VM1 network security group
resource "azurerm_network_security_group" "vm1_nsg" {
  name                = var.vm1_server_nsg_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allowssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

// vm2 network security group
resource "azurerm_network_security_group" "vm2_nsg" {
  name                = var.vm2_server_nsg_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allowssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

// network interface
// vm1 server network interface
resource "azurerm_network_interface" "vm1_server_NIC" {
  name                = var.vm1_server_nic_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private-subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.vm1_server_pip.id
  }
  tags = {
    environment = var.environment
  }
}

// vm2 server network interface
resource "azurerm_network_interface" "vm2_server_NIC" {
  name                = var.vm2_server_nic_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private-subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.vm2_server_pip.id
  }
  tags = {
    environment = var.environment
  }
}

// NSG associated with Network interfaces
// For vm1 server
resource "azurerm_network_interface_security_group_association" "aso_nic_vm1_server" {
  network_interface_id      = azurerm_network_interface.vm1_server_NIC.id
  network_security_group_id = azurerm_network_security_group.vm1_nsg.id
}
// For vm2 server
resource "azurerm_network_interface_security_group_association" "aso_nic_vm2_server" {
  network_interface_id      = azurerm_network_interface.vm2_server_NIC.id
  network_security_group_id = azurerm_network_security_group.vm2_nsg.id
}

// virtual machines 
// VM1 virtual machine
resource "azurerm_linux_virtual_machine" "vm1_server" {
  name                = var.vm1_vm_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = var.vm1_server_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm1_server_NIC.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
}

// virtual machines 
// vm2 virtual machine
resource "azurerm_linux_virtual_machine" "vm2_server" {
  name                = var.vm2_vm_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = var.vm2_server_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm2_server_NIC.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
}
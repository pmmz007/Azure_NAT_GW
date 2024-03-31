variable "rg_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "MyRG"
}

variable "location" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Southeast Asia"
}

variable "environment" {
  type        = string
  description = "(optional) describe your variable"
  default     = "development"
}

variable "vnet_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "my-vnet"
}

variable "address_space" {
  type        = string
  description = "(optional) describe your variable"
  default     = "10.0.0.0/16"
}

variable "private_subnet_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "private-subnet"
}

variable "private_subnet_address_prefixes" {
  type        = string
  description = "(optional) describe your variable"
  default     = "10.0.1.0/24"
}
// NAT GW
variable "nat_gw_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "lab_natgw"
}

variable "idle_timeout_in_minutes" {
  type        = string
  description = "(optional) describe your variable"
  default     = "4"
}

variable "nat_sku_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Standard"
}

# variable "nat_zones" {
#     type = string
#     description = "(optional) describe your variable"
#     default = "0"
# }
variable "nat_gw_pip_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "natgw_pip"
}

variable "pip_sku_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Standard"
}

variable "pip_allocation_method" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Static"
}

variable "vm1_server_nsg_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "vm1-server-NSG"
}

variable "vm2_server_nsg_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "vm2-server-NSG"
}

variable "vm1_server_public_ip_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "vm1-server-public-ip"
}
variable "vm1_server_allocation_method" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Static"
}
variable "vm2_server_public_ip_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "vm2-server-public-ip"

}
variable "vm2_server_allocation_method" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Static"
}

// network interface
variable "vm1_server_nic_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "vm1-server-nic"
}
variable "private_ip_address_allocation" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Dynamic"
}
variable "vm2_server_nic_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "vm2-server-nic"
}

// virtual machines
variable "vm1_vm_name" {
    type = string
    description = "(optional) describe your variable"
    default = "VM1"
}
variable "vm1_server_size" {
    type = string
    description = "(optional) describe your variable"
    default = "Standard_F2"
}

variable "vm2_vm_name" {
    type = string
    description = "(optional) describe your variable"
    default = "VM2"
}
variable "vm2_server_size" {
    type = string
    description = "(optional) describe your variable"
    default = "Standard_F2"
}

variable "admin_username" {
    type = string
    description = "(optional) describe your variable"
    default = "johnie"
}
variable "username" {
    type = string
    description = "(optional) describe your variable"
    default = "johnie"
}
variable "caching" {
    type = string
    default = "ReadWrite"
}
variable "storage_account_type" {
    type = string
    description = "(optional) describe your variable"
    default = "Standard_LRS"
}
variable "publisher" {
    type = string
    description = "(optional) describe your variable"
    default = "Canonical"
}
variable "offer" {
    type = string
    description = "(optional) describe your variable"
    default = "0001-com-ubuntu-server-jammy"
}
variable "sku" {
    type = string
    description = "(optional) describe your variable"
    default = "22_04-lts"
}
variable "image_version" {
    type = string
    description = "(optional) describe your variable"
    default = "latest"
}
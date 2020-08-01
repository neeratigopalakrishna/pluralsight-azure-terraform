#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type = string
  default = "myTFResourceGroup"
}

variable "location" {
  type    = string
  default = "eastus"
}


variable "vnet_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnet_names" {
  type    = list(string)
  default = ["web", "database"]
}

#############################################################################
# PROVIDERS
#############################################################################

provider "azurerm" {
  version = "~> 2.21.0"
  features {}
}

#############################################################################
# RESOURCES
#############################################################################

module "vnet-main" {
  source              = "Azure/vnet/azurerm"
  version             = "2.1.0"
  resource_group_name = var.resource_group_name
  vnet_name           = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.0.0/24", "10.0.1.0/24"]
  subnet_names        = ["web", "database"]
  nsg_ids             = {}

  tags = {
    environment = "dev"
    costcenter  = "it"

  }
}

#############################################################################
# OUTPUTS
#############################################################################

output "vnet_id" {
  value = module.vnet-main.vnet_id
}

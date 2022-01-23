# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # subscription_id = "..."
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-${var.prefix}"
  location = var.location
}

resource "azurerm_mssql_server" "example" {
  name                         = "sql-${var.prefix}"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.sql_user
  administrator_login_password = var.sql_password

  tags = {
    environment = var.environment
  }
}

resource "azurerm_sql_firewall_rule" "example" {
  name                = "AlllowAzureServices"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mssql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mssql_database" "example" {
  name                = "sqldb-${var.prefix}"
  server_id           = azurerm_mssql_server.example.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  sku_name            = "Basic"
  sample_name         = "AdventureWorksLT"

  tags = {
    environment = var.environment
  }

}

# resource "azurerm_app_service_plan" "example" {
#   name                = "plan-terraform-fyi"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   kind = linux

#   sku {
#     tier = "Standard"
#     size = "S1"
#   }
# }

# resource "azurerm_app_service" "example" {
#   name                = "app-terraform-fyi"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   app_service_plan_id = azurerm_app_service_plan.example.id

#   site_config {
#     dotnet_framework_version = "v6.0"
#     scm_type                 = "LocalGit"
#   }

#   connection_string {
#     name  = "Database"
#     type  = "SQLServer"
#     value = "Server=tcp:${azurerm_mssql_server.example.fully_qualified_domain_name};Database=${azurerm_mssql_database.example.name};User ID=${var.sql_user};Password=${var.sql_password};Trusted_Connection=False;Encrypt=True;"
#   }
# }

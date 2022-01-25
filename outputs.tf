output "app_service_name" {
  value = azurerm_app_service.example.name
}

output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.example.default_site_hostname}"
}

output "app_service_site_credential" {
  value = flatten(azurerm_app_service.example.site_credential)
}

output "sql_user" {
  description = "Database administrator login"
  value       = azurerm_mssql_server.example.administrator_login
}

output "sql_password" {
  description = "Database administrator password"
  value       = azurerm_mssql_server.example.administrator_login_password
  sensitive   = true
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.example.fully_qualified_domain_name
}
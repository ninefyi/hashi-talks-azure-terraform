# output "app_service_name" {
#   value = azurerm_app_service.main.name
# }

# output "app_service_default_hostname" {
#   value = "https://${azurerm_app_service.main.default_site_hostname}"
# }

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
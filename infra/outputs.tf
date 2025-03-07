# outputs.tf - Terraform outputs for Azure resources

output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.cosmosdb.endpoint
}

output "cosmosdb_primary_key" {
  value     = azurerm_cosmosdb_account.cosmosdb.primary_key
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_container_url" {
  value = "https://${azurerm_storage_account.storage.name}.blob.core.windows.net/${azurerm_storage_container.logos.name}"
}

output "function_app_url" {
  value = azurerm_linux_function_app.function_app.default_hostname
}
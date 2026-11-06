output "storage_account_name" {
  value = azurerm_storage_account.complement.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.complement.primary_blob_endpoint
}

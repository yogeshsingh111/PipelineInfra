output "storage_account_names" {
  value       = [for sa in var.stgaccount : sa.name] 
}
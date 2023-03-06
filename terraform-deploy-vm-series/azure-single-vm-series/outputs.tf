output "mgmt_ip_addresses" {
  description = "IP Address for VM-Series management"
  value       = "IP: ${module.vmseries.mgmt_ip_address}"
}

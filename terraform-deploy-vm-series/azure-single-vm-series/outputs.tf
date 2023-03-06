output "mgmt_ip_addresses" {
  description = "IP Addresses for VM-Series management"
  value       = "IP: ${module.vmseries.mgmt_ip_address}"
}

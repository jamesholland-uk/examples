output "vm-series_public_ips" {
  description = "IP Addresses for VM-Series management"
  value       = module.the_vmseries.public_ips
}

output "vm-series_public_ips" {
  description = "IP Address for VM-Series management"
  value       = module.the_vmseries.public_ips
}

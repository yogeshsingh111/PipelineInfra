output "lb_probe_ids" {
  description = "Map of Load Balancer probe IDs"
  value = { for key, probe in azurerm_lb_probe.lbprobe : key => probe.id }
}

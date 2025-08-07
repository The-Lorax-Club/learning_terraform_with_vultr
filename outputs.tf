output "instance_main_ip" {
  value       = vultr_instance.web.main_ip
  description = "The main IPv4 address of the Vultr instance"
}

output "instance_id" {
  value       = vultr_instance.web.id
  description = "The unique Vultr instance ID"
}

output "instance_label" {
  value       = vultr_instance.web.label
  description = "The label for the Vultr instance"
}

output "instance_os_id" {
  value       = vultr_instance.web.os_id
  description = "The OS ID used to create the Vultr instance"
}

output "instance_region" {
  value       = vultr_instance.web.region
  description = "The region in which the Vultr instance was deployed"
}

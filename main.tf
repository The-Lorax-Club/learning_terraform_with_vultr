resource "vultr_instance" "web" {
  label       = "HelloWorld"
  plan        = "vhf-1c-1gb"
  region      = "ord"
  os_id       = var.vultr_os_ubuntu_id
  enable_ipv6 = false
}

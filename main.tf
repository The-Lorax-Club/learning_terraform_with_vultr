resource "vultr_instance" "web" {
  label       = "HelloWorld"
  plan        = "vhf-1c-1gb"
  region      = "ord"
  os_id       = vultr_os-ubuntu-id
  enable_ipv6 = false
}

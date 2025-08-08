resource "vultr_instance" "web" {
  label       = "HelloWorld"
  plan        = "vhf-1c-1gb"
  region      = "ord"
  os_id       = data.vultr_os.ubuntu.id
  enable_ipv6 = false
}

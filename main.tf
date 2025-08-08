resource "vultr_instance" "web" {
  label       = "HelloWorld"
  plan        = "vhf-1c-1gb"
  region      = "chi"
  os_id       = 1743
  enable_ipv6 = false
}

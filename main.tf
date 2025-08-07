resource "vultr_instance" "web" {
  label      = "HelloWorld"
  plan       = "vhf-1c-1gb"      # Standard Small vcpu 1
  region     = "chi"             # Chicago
  os_id      = "2314"             # For Ubuntu 24.04 LTS the OS ID is 2314
  enable_ipv6 = false
}

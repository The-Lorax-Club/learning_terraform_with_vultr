resource "vultr_instance" "web" {
  label      = "HelloWorld"
  plan       = "vhf-1c-1gb"      # Standard Small vcpu 1
  region     = "chi"             # Example: New Jersey
  os_id      = "2314"             # Example: Ubuntu 20.04; Replace with your needed OS/app ID
  enable_ipv6 = false
}

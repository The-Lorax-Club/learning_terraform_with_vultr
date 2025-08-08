data "vultr_os" "ubuntu" {
  filter {
    name   = "name"
    values = ["Ubuntu 24.04 x64"]
  }
}

resource "vultr_instance" "web" {
  label       = "HelloWorld"
  plan        = "vhf-1c-1gb"
  region      = "chi"
  os_id       = data.vultr_os.ubuntu.id
  enable_ipv6 = false
}

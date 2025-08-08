resource "vultr_firewall_group" "web" {
  description = "Firewall group for HelloWorld"
}

resource "vultr_firewall_rule" "allow_ssh" {
  firewall_group_id = vultr_firewall_group.web.id
  protocol          = "tcp"
  port              = "22"
  subnet            = var.my_public_ip
  subnet_size       = 0
  notes             = "Allow SSH"
}

resource "vultr_firewall_rule" "allow_http" {
  firewall_group_id = vultr_firewall_group.web.id
  protocol          = "tcp"
  port              = "80"
  subnet            = var.my_public_ip
  subnet_size       = 0
  notes             = "Allow HTTP"
}

resource "vultr_instance" "web" {
  label             = "HelloWorld"
  plan              = "vhf-1c-1gb"
  region            = "ord"
  os_id             = var.vultr_os_ubuntu_id  # If you have a variables.tf
  enable_ipv6       = false
  firewall_group_id = vultr_firewall_group.web.id
}

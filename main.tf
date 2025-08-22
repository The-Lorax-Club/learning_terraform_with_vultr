resource "vultr_firewall_group" "admin" {
  description = "Firewall group for my IP to reach vultr instances for management"
}

resource "vultr_firewall_rule" "allow_ssh_from_my-ip" {
  firewall_group_id = vultr_firewall_group.admin.id
  protocol          = "tcp"
  port              = "22"
  subnet            = var.my_public_ip
  subnet_size       = 32
  ip_type           = "v4"
  notes             = "Allow SSH from My-IP"
}

resource "vultr_firewall_rule" "allow_http_from_my-ip" {
  firewall_group_id = vultr_firewall_group.admin.id
  protocol          = "tcp"
  port              = "80"
  subnet            = var.my_public_ip
  subnet_size       = 32
  ip_type           = "v4"
  notes             = "Allow HTTP from My-IP"
}

resource "vultr_firewall_rule" "allow_https_from_my-ip" {
  firewall_group_id = vultr_firewall_group.admin.id
  protocol          = "tcp"
  port              = "443"
  subnet            = var.my_public_ip
  subnet_size       = 32
  ip_type           = "v4"
  notes             = "Allow HTTPS from My-IP"
}

resource "vultr_instance" "keycloak" {
  label             = "keycloak"
  plan              = "vhf-1c-1gb"
  region            = "ord"
  os_id             = var.vultr_os_ubuntu_id  # If you have a variables.tf
  enable_ipv6       = false
  firewall_group_id = vultr_firewall_group.admin.id
}

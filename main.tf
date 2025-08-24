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

resource "vultr_firewall_rule" "allow_kc_http_from_my-ip" {
  firewall_group_id = vultr_firewall_group.admin.id
  protocol          = "tcp"
  port              = "8080"
  subnet            = var.my_public_ip
  subnet_size       = 32
  ip_type           = "v4"
  notes             = "Allow KeyCloak HTTP from My-IP"
}

resource "vultr_firewall_rule" "allow_signoz_http_from_my-ip" {
  firewall_group_id = vultr_firewall_group.admin.id
  protocol          = "tcp"
  port              = "3301"
  subnet            = var.my_public_ip
  subnet_size       = 32
  ip_type           = "v4"
  notes             = "Allow Keycloak HTTPS from My-IP"
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

resource "vultr_firewall_rule" "allow_kc_https_from_my-ip" {
  firewall_group_id = vultr_firewall_group.admin.id
  protocol          = "tcp"
  port              = "8443"
  subnet            = var.my_public_ip
  subnet_size       = 32
  ip_type           = "v4"
  notes             = "Allow Keycloak HTTPS from My-IP"
}

resource "vultr_instance" "iam_server" {
  label             = "keycloak"
  plan              = "vhf-1c-1gb"
  region            = "ord"
  os_id             = var.vultr_os_ubuntu_id  # If you have a variables.tf
  enable_ipv6       = false
  firewall_group_id = vultr_firewall_group.admin.id
  user_data         = file("${path.module}/scripts/iam_server-init.sh")
}

resource "vultr_block_storage" "iam_server_storage" {
  size_gb             = 20          # or whatever size you need
  region              = "ord"       # must match the instance region
  label               = "keycloak-data"
  attached_to_instance = vultr_instance.iam_server.id
  lifecycle {
    prevent_destroy = true
  }
}

resource "vultr_database" "keycloak_db" {
  db_type    = "pgsql"
  plan       = "vcdb-1c-1gb"
  region     = "ord"
  label      = "keycloak-db"
  version    = "15"  # Use appropriate PostgreSQL version
}

resource "vultr_database_user" "keycloak_user" {
  database_id = vultr_database.keycloak_db.id
  name        = "keycloak"
  password    = "secure_password"
}

resource "vultr_instance" "email_server" {
  label             = "mailcow"
  plan              = "vhf-1c-1gb"
  region            = "ord"
  os_id             = var.vultr_os_ubuntu_id  # If you have a variables.tf
  enable_ipv6       = false
  firewall_group_id = vultr_firewall_group.admin.id
  user_data         = file("${path.module}/scripts/email_server-init.sh")
}

resource "vultr_block_storage" "email_server_storage" {
  size_gb             = 20          # or whatever size you need
  region              = "ord"       # must match the instance region
  label               = "mailcow-data"
  attached_to_instance = vultr_instance.iam_server.id
  lifecycle {
    prevent_destroy = true
  }
}

resource "vultr_database" "mailcow_db" {
  db_type    = "mysql"
  plan       = "vcdb-1c-1gb"
  region     = "ord"
  label      = "mailcow-db"
  version    = "8"  # Use appropriate MySQL version
}

resource "vultr_database_user" "mailcow_user" {
  database_id = vultr_database.mailcow_db.id
  name        = "mailcow"
  password    = "secure_password"
}

resource "vultr_instance" "monitor_server" {
  label             = "signoz"
  plan              = "vhf-1c-1gb"
  region            = "ord"
  os_id             = var.vultr_os_ubuntu_id  # If you have a variables.tf
  enable_ipv6       = false
  firewall_group_id = vultr_firewall_group.admin.id
  user_data         = file("${path.module}/scripts/monitor_server-init.sh")
}

resource "vultr_database" "signoz_db" {
  db_type    = "clickhouse"
  plan       = "vcdb-1c-2gb"
  region     = "ord"
  label      = "signoz-db"
  version    = "latest"
}

resource "vultr_database_user" "signoz_user" {
  database_id = vultr_database.signoz_db.id
  name        = "signoz"
  password    = "secure_password"
}

resource "vultr_instance" "firewall" {
  label             = "pfsense"
  plan              = "vhf-1c-1gb"
  region            = "ord"
  os_id             = var.vultr_os_ubuntu_id  # If you have a variables.tf
  enable_ipv6       = false
  firewall_group_id = vultr_firewall_group.admin.id
  user_data         = file("${path.module}/scripts/firewall-init.sh")
}

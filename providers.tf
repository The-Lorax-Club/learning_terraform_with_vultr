terraform {
  required_providers {
    vultr = {
      source  = "hashicorp/vultr"
    }
  }
}

provider "vultr" {
  region  = "chi"
}

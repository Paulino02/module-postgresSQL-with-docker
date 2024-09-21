terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    postgresql = {
      source  = "NitriKx/postgresql"
      version = "1.21.2"
    }
  }
  backend "http" {}
  required_version = "> 1.3.6"
}

provider "docker" {
  host     = "ssh://admkeyclk@192.168.10.12:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no"]
}

provider "postgresql" {
  host     = "192.168.10.12"
  port     = 5432
  database = var.postgres_db
  username = var.postgres_user
  password = var.postgres_password
  sslmode  = "disable"
}
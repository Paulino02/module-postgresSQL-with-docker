resource "docker_image" "postgres" {
  name = var.image_name
}

resource "docker_container" "postgres" {
  name  = var.container_name
  image = docker_image.postgres.name

  ports {
    internal = 5432
    external = var.external_port
  }

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}"
  ]

  volumes {
    host_path      = var.volume_host_path
    container_path = "/var/lib/postgres/data"
  }
}

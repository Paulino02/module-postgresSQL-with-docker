module "postgres_container" {
  source            = "./postgresql-docker-provider"
  image_name        = var.image_name
  container_name    = var.container_name
  external_port     = var.external_port
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  postgres_db       = var.postgres_db
  volume_host_path  = var.volume_host_path
}

resource "null_resource" "wait_for_postgres" {
  provisioner "local-exec" {
    command = "sleep 60" # Aguarda 30 segundos
  }

  depends_on = [module.postgres_container]
}

resource "postgresql_database" "my_db" {
  name = "modeler"

  depends_on = [null_resource.wait_for_postgres]
}

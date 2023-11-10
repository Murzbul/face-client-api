resource "kubernetes_secret" "face-client" {
  metadata {
    name = "face-client"
  }

  data = {
    POSTGRES_USER     = var.POSTGRES_USER
    POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
    APP_SETTINGS = var.APP_SETTINGS
    DATABASE_URI = var.DATABASE_URI
    SECRET_KEY = var.SECRET_KEY
  }

  type = "Opaque"
}


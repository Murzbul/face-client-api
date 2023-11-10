resource "kubernetes_deployment" "web" {
  metadata {
    name = "web"
  }

  spec {
    selector {
      match_labels = {
        app = "web"
      }
    }

    replicas = 1

    template {
      metadata {
        labels = {
          app = "web"
        }
      }

      spec {
        container {
          image = "murzbul/face-client-api:1.0.13"
          name  = "web"

          port {
            container_port = 5000
          }

          env {
            name = "APP_SETTINGS"
            value_from {
              secret_key_ref {
                name = "face-client"
                key  = "APP_SETTINGS"
              }
            }
          }

          env {
            name = "DATABASE_URI"
            value_from {
              secret_key_ref {
                name = "face-client"
                key  = "DATABASE_URI"
              }
            }
          }

          env {
            name = "SECRET_KEY"
            value_from {
              secret_key_ref {
                name = "face-client"
                key  = "SECRET_KEY"
              }
            }
          }
        }
      }
    }
  }
}

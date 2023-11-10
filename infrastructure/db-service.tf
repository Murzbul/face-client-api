resource "kubernetes_stateful_set" "db" {
  metadata {
    name = "db"
  }

  spec {
    service_name = "db"
    replicas     = 1

    selector {
      match_labels = {
        app = "db"
      }
    }

    template {
      metadata {
        labels = {
          app = "db"
        }
      }

      spec {
        container {
          image   = "postgres:12"
          name    = "db"

          port {
            container_port = 5432
          }

          env {
            name = "POSTGRES_USER"
            value_from {
              secret_key_ref {
                name = "face-client"
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = "face-client"
                key  = "POSTGRES_PASSWORD"
              }
            }
          }
        }
      }
    }
  }
}

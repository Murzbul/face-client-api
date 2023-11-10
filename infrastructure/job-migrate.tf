
resource "kubernetes_job" "db_migration" {
  metadata {
    name = "face-client-api-db-migration"
  }

  spec {
    backoff_limit = 4

    template {
      metadata {
        labels = {
          job-name = "face-client-api-db-migration"
        }
      }

      spec {
        container {
          image   = "murzbul/face-client-api:1.1.0"
          name    = "db-migration"
          command = ["flask"]
          args    = ["--app", "main.py", "db", "upgrade"]

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

        restart_policy = "OnFailure"
      }
    }
  }
}


resource "digitalocean_kubernetes_cluster" "face-client" {
  name    = "face-client-production"
  region  = "nyc1"
  version = "1.28.2-do.0"

  node_pool {
    name       = "face-client-api-worker"
    size       = "s-1vcpu-2gb"
    node_count = 1
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2
  }
}


provider "digitalocean" {
  token = var.DO_TOKEN
}

provider "kubernetes" {
  host     = digitalocean_kubernetes_cluster.face-client.endpoint
  token    = digitalocean_kubernetes_cluster.face-client.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.face-client.kube_config[0].cluster_ca_certificate
  )
}

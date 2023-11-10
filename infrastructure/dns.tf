
output "load_balancer_ip" {
  value = kubernetes_service.web.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "api" {
  domain = "bibix.tech"
  type   = "A"
  name   = "test"
  value  = kubernetes_service.web.status.0.load_balancer.0.ingress.0.ip
}
resource "digitalocean_droplet" "jcpii" {
  image  = var.IMAGE
  name   = "production"
  region = var.REGION
  size   = var.SIZE
  ssh_keys = [data.digitalocean_ssh_key.terraform.id]

  connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.PATH_TO_PRIVATE_KEY)
        timeout = "2m"
  }

  provisioner "file" {
    source      = "init.sh"
    destination = "/tmp/init.sh"
  }

  provisioner "file" {
    source      = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "file" {
    source      = "traefik"
    destination = "/tmp/traefik"
  }

  provisioner "local-exec" {
    command = "echo ${digitalocean_droplet.jcpii.ipv4_address} >> public_ips.txt"
  }
}

resource "digitalocean_project_resources" "default" {
  project = var.PROJECT_ID
  resources = [
    digitalocean_droplet.jcpii.urn
  ]
}

resource "null_resource" "execute-script" {
  connection {
        host = digitalocean_droplet.jcpii.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.PATH_TO_PRIVATE_KEY)
        timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "bash /tmp/init.sh",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "export github_token=${var.github_token}",
      "chmod +x /tmp/provisioner.sh",
      "bash /tmp/provisioner.sh",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "export secure_password=${var.secure_password}",
      "chmod +x /home/ubuntu/traefik/install.sh",
      "bash /home/ubuntu/traefik/install.sh",
    ]
  }
}

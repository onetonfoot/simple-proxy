resource "digitalocean_droplet" "squid" {
  count = "${var.number_of_proxies}"

  image  = "ubuntu-18-04-x64"
  name   = "${var.server_name}-${count.index}"
  region = "sgp1"
  size   = "512mb"

  ssh_keys = [
    "${var.ssh_fingerprint}",
  ]

  provisioner "remote-exec" {
    script = "${path.module}/provisioning/squidSetup.sh"
  }
}

output "ips" {
  value = ["${digitalocean_droplet.squid.*.ipv4_address}"]
}

output "squid_names" {
  value = ["${digitalocean_droplet.squid.*.name}"]
}

output "number_of_proxies" {
  value = "${var.number_of_proxies}"
}

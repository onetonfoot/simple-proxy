provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

module "squid" {
  source          = "./squid"
  ssh_fingerprint = "${var.ssh_fingerprint}"

  #Change to desired number
  number_of_proxies = 10
  server_name       = "squid"
}

module "glider" {
  source = "./glider"

  #Available forward strategies:
  #  rr: Round Robin mode
  #  ha: High Availability mode
  #  lha: Latency based High Availability mode
  #  dh: Destination Hashing mode
  glider_mode = "rr"

  ssh_fingerprint   = "${var.ssh_fingerprint}"
  squid_ips         = ["${module.squid.ips}"]
  squid_names       = ["${module.squid.squid_names}"]
  number_of_proxies = "${module.squid.number_of_proxies}"
}

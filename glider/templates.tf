data "template_file" "glider_ip" {
  template = "${file("${path.module}/templates/glider_ip.tpl")}"
  count    = "${var.number_of_proxies}"

  vars = {
    squid_ip = "${element(var.squid_ips,count.index)}"
  }
}

data "template_file" "glider_config" {
  template = "${file("${path.module}/templates/glider_config.tpl")}"

  vars = {
    glider_mode = "${var.glider_mode}"
    value       = "${join("\n", data.template_file.glider_ip.*.rendered)}"
  }
}

data "template_file" "csv_ip" {
  template = "${file("${path.module}/templates/csv_ip.tpl")}"
  count    = "${var.number_of_proxies}"

  vars = {
    name     = "${element(var.squid_names,count.index)}"
    squid_ip = "${element(var.squid_ips,count.index)}"
  }
}

data "template_file" "csv" {
  template = "${file("${path.module}/templates/csv.tpl")}"

  vars = {
    glider_ip = "${digitalocean_droplet.glider.ipv4_address}"
    squid_csv = "${join("\n", data.template_file.csv_ip.*.rendered)}"
  }
}

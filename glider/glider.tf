resource "digitalocean_droplet" "glider" {
  image  = "ubuntu-18-04-x64"
  name   = "glider"
  region = "sgp1"
  size   = "512mb"

  ssh_keys = [
    "${var.ssh_fingerprint}",
  ]

  #Copy files
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /etc/glider",
    ]
  }

  provisioner "file" {
    content     = "${data.template_file.glider_config.rendered}"
    destination = "/etc/glider/glider.conf"
  }

  provisioner "file" {
    source      = "${path.module}/provisioning/glider"
    destination = "/usr/bin/glider"
  }

  provisioner "file" {
    source      = "${path.module}/provisioning/glider@.service"
    destination = "/etc/systemd/system/glider@.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/provisioning/gliderSetup.sh"
  }
}

resource "null_resource" "output_csv" {
  triggers {
    template = "${data.template_file.csv.rendered}"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.csv.rendered}\" > \"${path.root}\"/proxies.csv"
  }
}

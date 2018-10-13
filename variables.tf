# Variable definitions here. Variable values in terraform.tfvars
# This lets you keep your secrets out of git as terraform will ask you on the command line
# for any variables which dont have a value set
# but have been initialized
variable "digitalocean_token" {
  type = "string"
}

variable "ssh_fingerprint" {
  type = "string"
}

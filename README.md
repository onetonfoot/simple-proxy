# Simple Proxy

A Terraform project to make setting up proxies for web scrapping simple. The project has two parts:

* [Squid](http://www.squid-cache.org/) - A proxy server set up as an anonymous proxy to hide your IP.
* [Glider](https://github.com/nadoo/glider) - A forward proxy which will take your request and forward it to the squid severs. By using glider we can have a single IP in our scraping scripts but still utilize many different IPs, glider will handle the IP rotation. Glider can be run in different modes, such as round robin or high availability, you can tweak this in the `config.tf`. You can of course use the squid proxies by themselves if you wish.

# Getting Started


To get started clone the repo and put your digital ocean token and ssh finger print in `terraform.tfvars.example`. Then rename the file to `terraform.tfvars`.


Next run:

```bash

terraform init
terraform plan
terraform apply

```

This will setup and 10 squid servers and glider. It also  creates a file called `proxies.csv` which contains the glider and squid proxy IPs. 

To destroy your servers.

```bash
terraform destroy
```

In `config.tf` you can tweak parameters for  the number of proxies, glider forwarding stagey and the servers names. Happy Scrapping!

* TODO:
    * Add vultr as a VPS cos it's cheaper!
    * Be able to setup proxies in multiple different regions.
    * Add ability to setup password and username on squid/glider.

#!/bin/bash
# https://stackoverflow.com/questions/3297196/how-to-set-up-a-squid-proxy-with-basic-username-and-password-authentication
# https://stackoverflow.com/questions/48239975/how-do-i-setup-an-elite-http-squid-proxy-with-password-protection-on-ubuntu

sudo apt-get update && sudo apt-get -y upgrade


sudo apt-get install -y squid3 apache2-utils
rm /etc/squid/squid.conf
sudo tee /etc/squid/squid.conf > /dev/null <<EOF


#password
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwords
auth_param basic realm proxy
acl authenticated proxy_auth REQUIRED

# http
http_port 3128
http_access allow authenticated

dns_v4_first on
cache deny all
forwarded_for delete
tcp_outgoing_address $(curl ifconfig.co)
via off
http_access allow authenticated
http_access deny all

EOF

#create password
sudo touch /etc/squid/passwords
sudo chmod 777 /etc/squid/passwords
sudo htpasswd -c -b /etc/squid/passwords username password
systemctl restart squid

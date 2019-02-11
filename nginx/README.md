certbot produces the certificate then you have to copy the nginx.conf file.
[mozilla guide for nginx.conf](https://mozilla.github.io/server-side-tls/ssl-config-generator/)
 * resolver is not needed unless you need a reverse proxy and shit.
 * ssl_certificate -> fullchain
 * ssl_trusted_certificate -> chain

A workaround for [this bug](https://bugs.launchpad.net/ubuntu/+source/nginx/+bug/1581864) has been included.


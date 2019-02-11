sudo apt install \
    nginx\
    certbot \
    python-certbot-nginx
sudo ln -s /etc/nginx/sites-available/glassacademy /etc/nginx/sites-enabled/
sudo sh -c 'echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list'
sudo apt update
sudo apt -t stretch-backports install python3-certbot-nginx certbot
sudo certbot --nginx certonly
sudo certbot renew --dry-run
# workaround for this bug: https://bugs.launchpad.net/ubuntu/+source/nginx/+bug/1581864
sudo mkdir /etc/systemd/system/nginx.service.d
sudo sh -c 'printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" > /etc/systemd/system/nginx.service.d/override.conf'
sudo systemctl daemon-reload
sudo systemctl restart nginx

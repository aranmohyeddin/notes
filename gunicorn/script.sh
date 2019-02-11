pip install gunicorn
sudo mv gunicorn.service /etc/systemd/system/gunicorn.service
sudo mv gunicorn.socket /etc/systemd/system/gunicorn.socket
sudo mv gunicorn.conf /etc/tmpfiles.d/gunicorn.conf
sudo systemctl enable gunicorn.socket
sudo systemctl start gunicorn.socket
curl --unix-socket /run/gunicorn/socket http
sudo systemctl enable nginx.service
sudo systemctl start nginx

#!/bin/bash
data() {
read -p "enter your application to be installed:" app
status=$(systemctl is-active $app)
if [ $status == "inactive" ]
then
echo "your service is not active"
sudo dnf install $app -y
sudo systemctl enable --now $app
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo sed -i s/local/"all granted"/g /etc/httpd/conf.d/phpMyAdmin.conf 
sudo setenforce 0
echo "done" 
fi
}
data "httpd"
data "mysql-server"
data "phpMyAdmin"
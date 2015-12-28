apt-get update
echo "Installing Apache" | tee -a $logfile
apt-get -y install apache2 apache2-utils libapache2-mod-php5
a2enmod auth_digest
a2enmod reqtimeout
a2enmod ssl
sed -i "s/Timeout 300/Timeout 30/g" /etc/apache2/apache2.conf
echo "ServerSignature Off" >> /etc/apache2/apache2.conf
echo "ServerTokens Prod" >> /etc/apache2/apache2.conf
openssl req -x509 -nodes -days 365 -subj /CN=103.43.95.22 -newkey rsa:2048 -keyout /etc/ssl/ruweb.key -out /etc/ssl/ruweb.crt
htdigest -c /etc/apache2/htpasswd rutorrent nick
cp /var/www/html/index.html /var/www/index.html
cp /etc/apache2/sites-available/000-default.conf  /etc/apache2/sites-available/000-default.old
 wget -q --no-check-certificate --output-document=/etc/apache2/sites-available/000-default.conf https://raw.githubusercontent.com/dldfree/hello-world/master/000-default.conf
perl -pi -e "s/<Server IP>/103.43.95.22/g" /etc/apache2/sites-avail
able/000-default.conf
service apache2 restart

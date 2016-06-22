#!/usr/bin/env bash

# Enable trace printing and exit on the first error
set -ex

vagrant_dir="/vagrant"

apt-get update

# Install git
apt-get install -y git

# Setup Apache
apt-get install -y apache2
a2enmod rewrite
a2dismod mpm_event
a2enmod mpm_prefork
# Make sure Apache is run from 'vagrant' user to avoid permission issues
sed -i 's|www-data|vagrant|g' /etc/apache2/envvars

# Setup PHP
apt-get install -y language-pack-en-base
LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
apt-get update

# Install PHP 5.6
sudo apt-get install -y php5.6 php-xdebug php5.6-xml php5.6-mcrypt php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-bcmath php5.6-mbstring php5.6-soap php5.6-zip libapache2-mod-php5.6
echo '
xdebug.max_nesting_level=200
xdebug.remote_enable=1
xdebug.remote_host=192.168.10.1
xdebug.idekey=phpstorm' >> /etc/php/5.6/mods-available/xdebug.ini
a2dismod php5.6
rm -rf /etc/php/5.6/apache2
ln -s /etc/php/5.6/cli /etc/php/5.6/apache2

# Install PHP 7.0 and enable it by default
apt-get install -y php7.0 php7.0-mcrypt php7.0-curl php7.0-cli php7.0-mysql php7.0-gd php7.0-intl php7.0-xsl php7.0-bcmath php7.0-mbstring php7.0-soap php7.0-zip libapache2-mod-php7.0
a2enmod php7.0

# Install XDebug
apt-get install -y php7.0-dev
cd /usr/lib
git clone git://github.com/xdebug/xdebug.git
cd xdebug
phpize
./configure --enable-xdebug
make
make install
## Configure XDebug to allow remote connections from the host
touch /etc/php/7.0/cli/conf.d/20-xdebug.ini
echo 'zend_extension=/usr/lib/xdebug/modules/xdebug.so
xdebug.max_nesting_level=200
xdebug.remote_enable=1
xdebug.remote_host=192.168.10.1
xdebug.idekey=phpstorm' >> /etc/php/7.0/cli/conf.d/20-xdebug.ini
echo "date.timezone = America/Chicago" >> /etc/php/7.0/cli/php.ini
rm -rf /etc/php/7.0/apache2
ln -s /etc/php/7.0/cli /etc/php/7.0/apache2

update-alternatives --set php /usr/bin/php7.0

# Restart Apache
service apache2 restart

# Setup MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
apt-get install -q -y mysql-server-5.6 mysql-client-5.6
mysqladmin -uroot -ppassword password ''
# Make it possible to run 'mysql' without username and password
sed -i '/\[client\]/a \
user = root \
password =' /etc/mysql/my.cnf

# Setup Composer
if [ ! -f /usr/local/bin/composer ]; then
    cd /tmp
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
fi

# Install RabbitMQ (is used by Enterprise edition)
apt-get install -y rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
invoke-rc.d rabbitmq-server stop
invoke-rc.d rabbitmq-server start

# Install Varnish
apt-get install -y varnish

# Install ElasticSearch
apt-get install -y openjdk-7-jre
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb
dpkg -i elasticsearch-1.7.2.deb
update-rc.d elasticsearch defaults

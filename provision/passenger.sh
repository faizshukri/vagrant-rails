#!/usr/bin/env bash

source /home/vagrant/.rvm/scripts/rvm

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get -y install apt-transport-https ca-certificates

echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list

chown root: /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list

apt-get update
apt-get -y install nginx-extras passenger nodejs

sed -i 's/\# passenger_root/passenger_root/g' /etc/nginx/nginx.conf 
sed -i '/passenger_ruby/c\\tpassenger_ruby \/home\/vagrant\/.rvm\/gems\/'$RUBY_VERSION'\/wrappers\/ruby;' /etc/nginx/nginx.conf

cp /vagrant/provision/genesys.nginx.vhost /etc/nginx/sites-available/genesys
ln -s /etc/nginx/sites-available/genesys /etc/nginx/sites-enabled/genesys

service nginx restart
#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install --yes --force-yes software-properties-common

sudo add-apt-repository ppa:ondrej/php

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get update
sudo apt-get upgrade --yes --force-yes

sudo apt-get install --yes --force-yes \
    unzip \
    nginx \
    mysql-server-5.7 \
    git \
    curl

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

# install php with exts
for ver in '7.3' '5.6'; do
    sudo apt-get install --yes --force-yes \
        php$ver-cli php$ver-mysql php$ver-fpm php$ver-curl php$ver-gd php$ver-xml php$ver-mbstring php$ver-zip php$ver-sqlite3 php$ver-intl php$ver-soap php$ver-imagick php$ver-imap php$ver-json php$ver-apcu php$ver-bcmath \
        php$ver-dev 

    if [ "$ver" == "5.6" ]; then
        sudo apt-get install php$ver-mcrypt
    fi

    for sapi in 'fpm' 'cli'; do
        sudo sed -i".bak" 's/;sendmail_path =.*/sendmail_path=\/srv\/tools\/sendmail/g' /etc/php/$ver/$sapi/php.ini
        sudo sed -i".bak" 's/post_max_size =.*/post_max_size = 1G/g'                    /etc/php/$ver/$sapi/php.ini
        sudo sed -i".bak" 's/upload_max_filesize =.*/upload_max_filesize = 1G/g'        /etc/php/$ver/$sapi/php.ini
    done
    
    sudo cp /srv/etc/php/mods-available/xdebug.ini /etc/php/$ver/mods-available/xdebug.ini
done

# install xdebug ext from pecl
ext_dir_56=$(php5.6 -r "echo ini_get('extension_dir');")
ext_dir_73=$(php7.3 -r "echo ini_get('extension_dir');")

sudo pecl -d php_suffix=5.6 -d extension_dir=$ext_dir_56 uninstall xdebug
sudo pecl -d php_suffix=7.3 -d extension_dir=$ext_dir_73 uninstall xdebug

sudo pecl -d php_suffix=5.6 -d extension_dir=$ext_dir_56 install xdebug-2.5.5
sudo mv $ext_dir_56/xdebug.so $ext_dir_56/xdebug-5.6.so

sudo pecl install xdebug
sudo mv $ext_dir_56/xdebug-5.6.so $ext_dir_56/xdebug.so

sudo phpenmod xdebug
sudo service php7.3-fpm restart
sudo service php5.6-fpm restart

# enable sites
sudo rm -rf /etc/nginx/sites-enabled/*
sudo rm /etc/nginx/sites-available/default*

cd /etc/nginx/sites-available/
for i in *
do
    if [[ "${i}" != "template" ]]; then
        sudo ln -s /etc/nginx/sites-available/$i /etc/nginx/sites-enabled/$i
    fi
done
sudo service nginx restart

curl -sL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > /home/vagrant/git-prompt.sh

cp /srv/.profile /home/vagrant/.profile
cp /srv/.vimrc /home/vagrant/.vimrc

INSTALL AND CONF. ZABBIX SERVER


# wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu20.04_all.deb 
# dpkg -i zabbix-release_6.0-1+ubuntu20.04_all.deb 
# apt update 
# apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent 
# apt update && sudo apt upgrade 
# apt -y install software-properties-common
# apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc' 
# add-apt-repository 'deb [arch=amd64] http://mariadb.mirror.globo.tech/repo/10.5/ubuntu focal main'
# apt update
# apt install mariadb-server-10.5 mariadb-client-10.5 mariadb-common
# systemctl start mariadb
# systemctl enable mariadb
# mysql_secure_installation 
# mysql -uroot -p
SELECT VERSION(); 
mysql> create database db_zabbix character set utf8mb4 collate utf8mb4_bin; 
mysql> create user u_zabbix@localhost identified by 'password'; 
mysql> grant all privileges on db_zabbix.* to u_zabbix@localhost; 
mysql> quit; 
# zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -p zabbix 
/etc/zabbix/zabbix_server.conf 
DBPassword=password 
# systemctl restart zabbix-server zabbix-agent apache2 
# systemctl enable zabbix-server zabbix-agent apache2 
Connect to your newly installed Zabbix frontend: http://192.168.222.197/zabbix 
# rm -rf /var/www/html
# ln -s /usr/share/zabbix/ /var/www/html 
# a2enmod rewrite 
# a2enmod ssl
# vim /etc/php/7.4/apache2/php.ini

memory_limit = 128M 

post_max_size = 16M 

max_execution_time = 300 

max_input_time = 300 

mbstring.func_overload = 0 

# vim /etc/apache2/sites-enabled/000-default.conf 

Redirect permanent / https://192.168.222.197

# systemctl restart apache2
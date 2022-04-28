INSTALL AND CONF. ZABBIX SERVER

# FOR UBUNTU
dpkg-reconfigure tzdata
dpkg-reconfigure locales
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu20.04_all.deb 
dpkg -i zabbix-release_6.0-1+ubuntu20.04_all.deb 
apt update  
apt -y install software-properties-common
apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc' 
add-apt-repository 'deb [arch=amd64] http://mariadb.mirror.globo.tech/repo/10.5/ubuntu focal main'
apt update
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent \
	mariadb-server-10.5 mariadb-client-10.5 mariadb-common \
	apache2 php php-mysql php-mysqlnd php-ldap php-bcmath php-mbstring php-gd php-pdo php-xml libapache2-mod-php
systemctl start mariadb
vim /etc/mysql/mariadb.conf.d/50-server.cnf
	...[mysqld]
	port                    = 6106
mysql_secure_installation 
mysql -uroot -p
	SELECT VERSION(); 
	create database db_zabbix character set utf8mb4 collate utf8mb4_bin; 
	create user u_zabbix@localhost identified by 'YOUR-DB-PASSWORD'; 
	grant all privileges on db_zabbix.* to u_zabbix@localhost; 
	quit; 
zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -u u_zabbix -p db_zabbix 
vim /etc/zabbix/zabbix_server.conf
	DBName=db_zabbix
	DBUser=u_zabbix
	DBPassword=YOUR-DB-PASSWORD 
systemctl restart zabbix-server zabbix-agent apache2 
systemctl enable zabbix-server zabbix-agent apache2 mariadb mariadb
Connect to your newly installed Zabbix frontend: http://YOUR-IP-SERVER/zabbix
	Datos de Conexión a Database.
	User: Admin
	Password: zabbix
rm -rf /var/www/html
ln -s /usr/share/zabbix/ /var/www/html 
a2enmod rewrite 
a2enmod ssl
vim /etc/php/7.4/apache2/php.ini
	memory_limit = 128M 
	post_max_size = 16M 
	max_execution_time = 300 
	max_input_time = 300 
	mbstring.func_overload = 0 
vim /etc/apache2/sites-enabled/000-default.conf 
	Redirect permanent / https://YOUR-IP-SERVER
a2ensite default-ssl.conf
	systemctl restart apache2

reboot

# FOR DEBIAN
dpkg-reconfigure tzdata
dpkg-reconfigure locales
wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-1+debian11_all.deb
apt install ./zabbix-release_6.0-1+debian11_all.deb
apt update
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent \
	mariadb-server-10.5 mariadb-client-10.5 mariadb-common \
	apache2 php php-mysql php-mysqlnd php-ldap php-bcmath php-mbstring php-gd php-pdo php-xml libapache2-mod-php
systemctl start mariadb
mysql_secure_installation 
mysql -uroot -p
	SELECT VERSION(); 
	create database db_zabbix character set utf8mb4 collate utf8mb4_bin; 
	create user u_zabbix@localhost identified by 'password'; 
	grant all privileges on db_zabbix.* to u_zabbix@localhost; 
	quit; 
zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -u u_zabbix -p db_zabbix
vim /etc/mysql/mariadb.conf.d/50-server.cnf
	...[mysqld]
	port                    = 6106
mysql_secure_installation 
mysql -uroot -p
	SELECT VERSION(); 
	create database db_zabbix character set utf8mb4 collate utf8mb4_bin; 
	create user u_zabbix@localhost identified by 'YOUR-DB-PASSWORD'; 
	grant all privileges on db_zabbix.* to u_zabbix@localhost; 
	quit; 
zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -u u_zabbix -p db_zabbix 
vim /etc/zabbix/zabbix_server.conf
	DBName=db_zabbix
	DBUser=u_zabbix
	DBPassword=YOUR-DB-PASSWORD 
systemctl restart zabbix-server zabbix-agent apache2 
systemctl enable zabbix-server zabbix-agent apache2 mariadb mariadb
Connect to your newly installed Zabbix frontend: http://YOUR-IP-SERVER/zabbix
	Datos de Conexión a Database.
	User: Admin
	Password: zabbix
rm -rf /var/www/html
ln -s /usr/share/zabbix/ /var/www/html 
a2enmod rewrite 
a2enmod ssl
vim /etc/php/7.4/apache2/php.ini
	memory_limit = 128M 
	post_max_size = 16M 
	max_execution_time = 300 
	max_input_time = 300 
	mbstring.func_overload = 0 
vim /etc/apache2/sites-enabled/000-default.conf 
	Redirect permanent / https://YOUR-IP-SERVER
a2ensite default-ssl.conf
systemctl restart apache2

reboot

INSTALL AND CONF. ZABBIX AGENT

https://www.zabbix.com/download_agents


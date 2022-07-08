# Zabbix Proxy
wget wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-1+debian11_all.deb
apt install ./zabbix-release_6.0-1+debian11_all.deb
apt update && apt upgrade 
apt -y install zabbix-proxy-mysql zabbix-sql-scripts \
	mariadb-server
vim /etc/mysql/mariadb.conf.d/50-server.cnf
	...[mysqld]
	port                    = 6106
systemctl restart mariadb
systemctl enable mariadb
mariadb-secure-installation
mysql -uroot -p
	SELECT VERSION(); 
	mysql> create database db_zbxproxy character set utf8mb4 collate utf8mb4_bin; 
	mysql> create user u_zbxproxy@localhost identified by 'zabbixDBpass'; 
	mysql> grant all privileges on db_zbxproxy.* to u_zabbix_proxy@localhost identified by 'zabbixDBpass';
	mysql> quit;
cat /usr/share/doc/zabbix-sql-scripts/mysql/proxy.sql | mysql -u u_zbxproxy -p'zabbixDBpass' db_zbxproxy
vim /etc/zabbix/zabbix_proxy.conf
DBName=db_zabbix_proxy
DBUser=u_zabbix_proxy
DBPassword=PASSWORD
DBPort=6106
ConfigFrequency=100
Server=192.168.222.197 (IP/DNS Zabbix Server)
systemctl restart zabbix-proxy
systemctl enable zabbix-proxy
https://192.168.222.197/
Administration - Proxies - Create proxy
Proxy name: TesteProxy
Proxy address: 10.0.210.202 (IP Proxy Server)
vim /etc/zabbix/zabbix_proxy.conf
	ProxyMode=0
	Server=192.168.222.197
	Hostname=TesteProxy
	DBName=db_zabbix_proxy
	DBUser=u_zabbix_proxy
	DBPassword=9F*oUG*pN.ITPg+n
	DBPort=6106
	ConfigFrequency=100
	Configuration - Hosts
	Selecione os hosts para aplicar
	Mass update
	Monitored by proxy: TesteProxy
	Ativar encriptação Proxy - Zabbix Server
openssl rand -hex 32
e8bbf838dde6a200e47c519c984b268d2ff0e43b9c2719534aca53ed2e96a589
vim /etc/zabbix/zabbix_proxy.psk
chown zabbix:zabbix /etc/zabbix/zabbix_proxy.ps
chmod 644 /etc/zabbix/zabbix_proxy.psk
vim /etc/zabbix/zabbix_proxy.conf
TLSConnect=psk
TLSAccept=psk
TLSPSKFile=/etc/zabbix/zabbix_proxy.psk
TLSPSKIdentity=ZBX-PROXY-PSK
Administration - Proxies
Seleccione Proxie criado - Encryption
Connections from proxy: PSK
PSK identity: ZBX-PROXY-PSK
PSK: e8bbf838dde6a200e47c519c984b268d2ff0e43b9c2719534aca53ed2e96a589
systemctl restart zabbix-proxy
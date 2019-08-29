# roger-skyline
**authors**
- ujyzene
- kbins

## VM Part
1. create non-root user

	```
	adduser username
	# opt:
	# adduser username sudo
	```

2. add user sudo rights

	Install sudo
	```
	apt-get install sudo
	```
	change `/etc/sudoers` use `visudo`
	```
	# add in "User privilege spec"
	username ALL=(ALL:ALL) ALL
	```

3. static IP

	change `/etc/network/interface`
	```
	auto enp0s3
		iface enp0s3 inet static
		address 192.168.0.65
		netmask 255.255.255.252
		gateway 192.168.0.1
	```
	restart net daemon
	```
	sudo service networking restart
	```

4. change ssh config

	change port
	```
	#in /etc/ssh/sshd_config
	Port NNNNN
	```
	generate keys
	```
	ssh-keygen -t rsa
	ssh-copy-id -p NNNNN -i ~/.ssh/key_name.pud username@host
	ssh -p 'NNNNN' username@host
	```
	root connect disable
	password authentication closed
	```
	#in /etc/ssh/sshd_config
	PermitRootLogin no
	PasswordAuthentication no
	```
	restart sshd

5. ufw

	install ufw
	```
	sudo apt-get install ufw
	```
	status firewall
	```
	sudo ufw status
	```
	enable ufw and configurate
	```
	sudo ufw enable
	sudo ufw allow 80/tcp	# rule for http
	sudo ufw allow 443		# rule for https
	sudo ufw allow NNNNN	# rule for custom ssh port
	sudo ufw status			# check
	```
	allow 80 and 443 ports if use web server

	if need to configurate icmp, dhcp client, brdcast
	```
	sudo vim /etc/ufw/before.rules
	# and comment the right part
	```
	apply changes
	```
	sudo ufw reload
	```

6. fail2ban

	installation
	```
	sudo apt-get install fail2ban
	```
	user settings are best stored in .local file (not .conf)
	```
	sudo vim /etc/fail2ban/jail.local
	```
	```
	#in jail.local

	[DEFAULT]
	ignoreip = 127.0.0.1
	bantime = 600

	[sshd]
	enabled = true
	port = 52121, ssh
	action = iptables[name=SSH, port=52121, protocol=tcp]
	filter = sshd
	logpath = %(sshd_log)s
	backend = %(sshd_backend)s
	maxretry = 3
	```
	restart daemon
	```
	sudo service fail2ban restart
	```

7. portsenty

	Install portsentry
	```
	sudo apt-get install portsentry
	```
	Config /etc/portsentry/portsentry.conf
	```
	BLOCK_UDP="1"
	BLOCK_TCP="1"

	# iptables support for Linux (uncomment this)
	KILL_ROUTE="/sbin/iptables -I INPUT -s $TARGET$ -j DROP"
	```
	Change mode of portsentry
	```
	# /etc/default/portsentry
	TCP_MODE="atcp"
	UDP_MODE="audp"
	```
	or
	```
	portsentry -atcp
	portsentry -audp
	```

8. Disable services

	```
	sudo systenctl disable apt-daily.timer
	sudo systenctl disable apt-daily-upgrade.timer
	sudo systenctl disable console-setup.service
	sudo systenctl disable keyboard-setup.service
	```

9. Autoupdate script

	Script - `/files/update_script.sh`

	Add to /etc/crontab
	```
	@reboot root /usr/local/bin/update_scrip
	0 4 * * 1 root /usr/local/bin/update_script
	```

10. Monitoring /etc/crontab

	Script - `/files/cronMonitor.sh`

	Add to /etc/crontab
	```
	0 0 * * * root /usr/local/bin/cronMonitor
	```

## Web part
1. config ufw rules

	```shell
	sudo ufw allow 80/tcp
	sudo ufw allow 443/tcp
	```

2. config fail2ban fot http and https

	```
	# add to /etc/fail2ban/jail.local

	[http-get-dos]
	enabled = true
	port = http,https
	action = iptables[name=HTTP, port=http, protocol=tcp]
	filter = http-get-dos
	logpath = /var/log/apache2/access.log
	findtime = 300
	maxretry = 300
	```

3. Install apache2 and other packages

	```shell
	sudo apt-get install apache2 ... etc
	```

4. Create non-root user

	```shell
	sudo adduser --no-create-home --shell /bin/false --ingroup www-data username
	```

5. Create some dirs in `/var/www/` for domens

6. Create self-signed ssl

	```shell
	sudo openssl req -x509 -newkey rsa -keyout /etc/ssl/private/server.pem -out /etc/ssl/certs/server.pem -nodes -days 365 -subj '/CN=roger-skyline'
	```

	key in `/etc/ssl/private/server.pem`
	cert in `/etc/ssl/certs/server.pem`

7. Create configs in `/etc/apache2/sites-available/` and enable it

	```shell
	sudo a2ensite domen.com
	```

	add vhost on 443 for ssl
	redirect http to https

8. Reload apache2 daemon

	```shell
	sudo service apache2 reload
	```

9. for use domain name for connect to web app

	on server
	```
	# add to /etc/hosts
	127.0.0.1 site.com
	127.0.0.1 site.org
	..etc..
	```

	and chnge configs DNS or /etc/hosts (on host machine)
	```
	{ip_addr_server} site.com
	{ip_addr_server} site.org
	..etc..
	```

10. auto deploy

	Connect git repo and /var/www/site

	Update script
	```
	#!/bin/bash

	cd /var/www/app.local/
	reply=$(/usr/bin/git pull)

	if [[ $reply != "Already up to date." ]]; then
		/usr/bin/systemctl reload apache2
	fi
	```

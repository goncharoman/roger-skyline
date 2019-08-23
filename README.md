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
	stop ssh daemon
	```
	sudo service ssh stop
	```
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
5.
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
6.
	fail2ban
	
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
	!notes
	https://github.com/fail2ban/fail2ban/issues/1092



	ansible vault passwd - q1234
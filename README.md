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

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
	#
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

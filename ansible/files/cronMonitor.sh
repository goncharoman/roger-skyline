#! /bin/bash

CHSFILE='/var/tmp/chs-crontab'
CRONFILE='/etc/crontab'
TMP="$(sudo md5sum $CRONFILE)"

if [[ -e  $CHSFILE ]]; then
	if [[ $TMP == "$(cat $CHSFILE)" ]]; then
		echo $TMP > $CHSFILE
	else
		echo "File /etc/crontab modified!" | mail -s "Crontab modified" root
	fi
else
	echo $TMP > $CHSFILE
fi

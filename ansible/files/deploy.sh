#!/bin/bash

cd /var/www/app.local/
reply=$(/usr/bin/git pull)

if [[ $reply != "Уже обновлено." ]]; then
	/usr/bin/systemctl reload apache2
fi

#!/bin/bash

cd /var/www/app.local/flaskapp
git checkout . > /dev/null
reply=$(/usr/bin/git pull)

if [[ $reply != "Уже обновлено." ]]; then
	/usr/bin/systemctl reload apache2
fi

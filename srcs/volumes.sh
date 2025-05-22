#!/usr/bin/bash

if [ ! -d /home/$USER/data ]; then
	mkdir -p /home/$USER/data/MyDatabase/Wordpress
	mkdir -p /home/$USER/data/MyDatabase/MariaDB
	mkdir -p /home/${USER}/data/logs/fail2ban
	mkdir -p /home/${USER}/data/logs/nginx
	touch /home/${USER}/data/logs/nginx/access.log
	touch /home/${USER}/data/logs/fail2ban/wordpress.log
fi
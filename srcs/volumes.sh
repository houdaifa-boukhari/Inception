#!/usr/bin/bash

if [ ! -d /home/$USER/data ]; then
	mkdir -p /home/$USER/MyDatabase/Wordpress
	mkdir -p /home/$USER/MyDatabase/MariaDB
	mkdir -p /home/${USER}/logs/fail2ban
	mkdir -p /home/$USER/logs/vsftpd
	mkdir -p /home/${USER}/logs/nginx
	touch /home/$USER/logs/vsftpd/vsftpd.log
	touch /home/${USER}/logs/nginx/access.log
	touch /home/${USER}/logs/fail2ban/wordpress.log
	touch /home/${USER}/logs/fail2ban/vsftpd.log 
fi
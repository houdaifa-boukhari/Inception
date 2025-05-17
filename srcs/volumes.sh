#!/usr/bin/bash

if [ ! -d /home/$USER/data ]; then
	mkdir -p /home/$USER/MyDatabase/Wordpress
	mkdir -p /home/$USER/MyDatabase/MariaDB
	mkdir -p /home/${USER}/logs/fail2ban
	mkdir -p /home/$USER/logs/vsftpd
	touch /home/$USER/logs/vsftpd/vsftpd.log
fi
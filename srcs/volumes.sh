#!/usr/bin/bash

if [ ! -d /home/$USER/data ]; then
	mkdir -p /home/$USER/MyDatabase/Wordpress
	mkdir -p /home/$USER/MyDatabase/MariaDB
fi
#!/bin/bash

useradd -m -d /home/$FTP_USER -s /bin/bash $FTP_USER && echo "$FTP_USER:$FTP_PASS" | chpasswd

/usr/sbin/vsftpd /etc/vsftpd.conf

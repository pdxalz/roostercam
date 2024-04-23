#!/bin/bash

echo "rooster:${FTP_PASSWORD}" | chpasswd
vsftpd /etc/vsftpd.conf

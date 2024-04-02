#!/bin/bash
echo "If you have a cifs error at somepoint and typing "modprobe cifs" indicates that cifs is not installed, please do 'sudo apt-get install cifs-util linux-modules-extra-aws' and reboot"
set -e
echo "Please give us your IMN username (of the form Tx-FirstnameL)"
read username
echo "Please give us your IMN password. It will be safely saved in root/.filersmbcredentials"
read -sp "Enter password " password
echo

echo "Creating credentials"
touch /root/.filersmbcredentials
echo "username=$username" > /root/.filersmbcredentials
echo "password=$password" >> /root/.filersmbcredentials
echo "domain=imn.u-bordeaux2.fr" >> /root/.filersmbcredentials
chmod 600 /root/.filersmbcredentials

echo "Are you sure your username and password are correct? You can display them either by running 'sudo cat /root/.filersmbcredential'"

while true; do

read -p "Press y to continue, n to abort, s to show configuration" yn

case $yn in 
  [sS] ) cat /root/.filersmbcredential;;
	[yY] )
		break;;
	[nN] ) exit();;
	* ) echo invalid response;;
esac

done

echo "Installing required librairies. You may be prompted by a scary screen for keberos installation. Do not enter anything and select OK. Press any key co continue"
read useless
apt install -y keyutils cifs-utils krb5-user krb5-config libkrb5-dev
echo "Configuring krb5"
cat ./krb5.conf /etc/krb5.conf > ./_tmp.conf
mv ./_tmp.conf /etc/krb5.conf
echo -e "addent -password -p $username@IMN.U-BORDEAUX2.FR -k 1 -e aes256-cts\n$password\nwrite_kt /etc/krb5.keytab" | ktutil



echo "Adding automatic mount points"
for i in "${ADDR[@]}"; do
  mkdir -p "/media/filer2/$i"
  echo "//filer2-IMN.imn.u-bordeaux2.fr/$i    /media/filer2/$i cifs    users,credentials=/root/.filersmbcredentials,iocharset=utf8,rw,sec=krb5i,file_mode=0777,dir_mode=0777    0    0" >> /etc/fstab
done

echo "Mounting filer drives..."
mount -a



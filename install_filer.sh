#!/bin/bash
echo "If you have a cifs error at somepoint and typing "modprobe cifs" indicates that cifs is not installed, please do 'sudo apt-get install cifs-util linux-modules-extra-aws' and reboot"
set -e
echo "Please give us your IMN username (of the form Tx-FirstnameL)"
read username
echo "Please give us your IMN password. It will be safely saved in root/.smbcredentials"
read -sp "Enter password " password
echo
echo "Please give us the mount points you are interested in separated by ; and no spaces (for example: T4;T4b)"
read mountpoints

mp=""
sep=""
IFS=';' read -ra ADDR <<< "$mountpoints"
for i in "${ADDR[@]}"; do
  mp=$mp$sep$i
  sep=", "
done

echo "Please be sure of your username, password and mount points, otherwise you might need help to change the settings later on. Rerunning the script may not be sufficient."
while true; do

read -p "Do you want your password to be displayed to check that it is correct? (y/n) " yn

case $yn in 
	[yY] ) echo "Current configuration:";
        echo "Username :$username";
        echo "Password :$password";
        echo "MountPoints :[$mp]";
		break;;
	[nN] ) echo "Current configuration:";
        echo "Username :$username";
        echo "Password :hidden";
        echo "MountPoints :[$mp]";
        break;;
	* ) echo invalid response;;
esac

done

while true; do

read -p "Do you want to proceed? (y/n) " yn

case $yn in 
	[yY] ) echo ok, we will proceed;
		break;;
	[nN] ) echo exiting...;
		exit;;
	* ) echo invalid response;;
esac

done 

echo "Installing required librairies. You may be prompted by a scary screen for keberos installation. Do not enter anything and select OK. Press any key co continue"
read useless
apt install -y keyutils krb5-user krb5-config libkrb5-dev
echo "Configuring krb5"
cat ./krb5.conf /etc/krb5.conf > ./_tmp.conf
mv ./_tmp.conf /etc/krb5.conf
echo "addent -password -p $username@IMN.U-BORDEAUX2.FR -k 1 -e aes256-cts\n$password\nwrite_kt /etc/krb5.keytab" | ktutil

echo "Creating credentials"
touch /root/.filersmbcredentials
echo "username=$username" > /root/.filersmbcredentials
echo "password=$password" >> /root/.filersmbcredentials
echo "domain=imn.u-bordeaux2.fr" >> /root/.filersmbcredentials
chmod 600 /root/.filersmbcredentials

echo "Adding automatic mount points"
for i in "${ADDR[@]}"; do
  mkdir -p "/media/filer2/$i"
  echo "//filer2-IMN.imn.u-bordeaux2.fr/$i    /media/filer2/$i cifs    users,credentials=/root/.smbcredentials,iocharset=utf8,rw,sec=krb5i,file_mode=0777,dir_mode=0777    0    0" >> /etc/fstab
done

echo "Mounting filer drives..."
mount -a



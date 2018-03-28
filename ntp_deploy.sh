#!/bin/bash

#========== verify set up ntp server========

verif=$(ls -la /etc/ | grep 'ntp.conf' | wc -l);

#========decision-making level======

if [ ${verif} -eq 0 ]
then
echo "ntp server not installed. install now.... ";
apt-get -y install ntp;
#========apply setting
cat /dev/null>/etc/ntp.conf
touch /etc/ntp_verif.conf
cat /dev/null>/etc/ntp_verif.conf
for  var1 in 0 1 2 3
do
echo "server $var1.ua.pool.ntp.org">>/etc/ntp.conf
echo "server $var1.ua.pool.ntp.org">>/etc/ntp_verif.conf
done
service ntp restart;
#==========================
else
echo "ntp server already installed in you Server"
# If the service was installed, then apply the settings
#========apply setting
cat /dev/null>/etc/ntp.conf
touch /etc/ntp_verif.conf
cat /dev/null>/etc/ntp_verif.conf
for  var1 in 0 1 2 3
do
echo "server $var1.ua.pool.ntp.org">>/etc/ntp.conf
echo "server $var1.ua.pool.ntp.org">>/etc/ntp_verif.conf
done
service ntp restart;

fi

#==== put veryfy file to /usr/bin=====
dir=$(pwd);
cp "$dir/ntp_verify.sh" "/usr/bin/ntp_verify.sh"


#======== write to cron job =============

cronjob="*/5 * * * * /usr/bin/ntp_verify.sh"
(crontab -u root -l; echo "$cronjob" ) | crontab -u root -



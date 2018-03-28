#!/bin/bash

#=====verify run service======
service=$(ps aux | grep [n]tp | wc -l);
if [${service} -eq 0]  #1
then
service ntp start;


else
#========verify level =============

verif=$(cmp /etc/ntp.conf /etc/ntp_verif.conf);
 if [ -z $verif ] #2
then
    echo "Empty string === verify success"
    
else
                #*****************
echo "NOT Empty string"
      #=========look change file===
diff -c /etc/ntp.conf /etc/ntp_verif.conf
      #======= reload conf file====
cat /dev/null>/etc/ntp.conf
for  var1 in 0 1 2 3
do
echo "server $var1.ua.pool.ntp.org">>/etc/ntp.conf
done
service ntp restart;
               #******************
fi #2

fi  #1





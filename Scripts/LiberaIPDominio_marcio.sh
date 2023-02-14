#!/bin/bash
SHELL=/bin/sh
PATH=/sbin:/usr/sbin:/usr/bin:/bin

ping -c 4 dominio.com.br | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' | sed -n -e 1p | awk -F " " '{print "IPP " $1 }' >/home/verifica-novoip.txt

cat /home/verifica-novoip.txt | sed -r 's/(IPP)//g'|
while read  IPP
do

VERIFICA=$( cat /etc/csf/csf.allow | grep "\b$IPP\b" | wc -l   )

if [ "$VERIFICA" -gt "0" ]
then
echo -e "o ip $IPP Já foi liberado no CSF"
else
echo -e "IP $IPP Sendo Liberado no CSF "
csf -dr $IPP
csf -a $IPP "Marcos Sandro (Cliente)"
/scripts/cphulkdwhitelist $IPP
echo -e " Caro admin o dominio myserversnr.ddns.net mudou para o IP $IPP \n\n por esse motivo fizemos a liberação no firewall " | mail -s " dominio myserversnr.ddns.net mudou de ip " seu@email.com.br
fi
done

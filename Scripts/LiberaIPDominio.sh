#!/bin/bash

DOMINIOS="dominio1.com.br dominio2.com.br dominio3.com.br"

for i in $DOMINIOS
do
	IP=$(ping -c 1 $i | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' | sed -n -e 1p)

	grep $IP /etc/csf/csf.allow

	if [ $? = 1 ]
	then
		csf -a $IP "Adicionado através do script $0" # Adiciona na Whitelist
		/scripts/cphulkdwhitelist $IP # Adiciona na Whitelist do CP Hulk

		echo -e "Caro ADMIN, o domínio $i mudou para o IP $IP e foi liberado no Firewall" | mail -s "Domínio $i mudou de IP" seu@email.com.br
	fi
done

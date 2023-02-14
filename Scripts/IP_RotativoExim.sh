#!/bin/bash
# Desenvolvido por: Mário Augusto Paglia Junior
# Paglia Host Brasil: www.pagliahost.com.br
#
# Script para gerar rotatividade de IPs no Exim do cPanel/WHM
# Criado em: 07/12/2017
#
# Versões:
#
# 1.0 - Desenvolvimento e criação do script

IPS="IP1 IP2 IP3"

while sleep 0
do
for ROTACIONAR in $IPS
do
	echo "*: $ROTACIONAR" > /etc/mailips
	sleep 10
done 
done 
#!/bin/bash
# Desenvolvido por: Mário Augusto Paglia Junior
# Paglia Host Brasil: www.pagliahost.com.br
#
# Script para verificação de load máximo.
#
# Versões:
#
# 1.0 - 05/03/2018 - Desenvolvimento e criação do script

EXTRAIR_LOAD=$(uptime | awk '{print $11}' | cut -d "." -f1)
NUCLEOS=$(grep -c processor /proc/cpuinfo)
NUCLEO_MAX=$(($NUCLEOS*2))

if [ "$EXTRAIR_LOAD" -gt "$NUCLEO_MAX" ]
then
	echo "LOAD ACIMA DO PERMITIDO!"
else
	echo "LOAD NORMAL"
fi
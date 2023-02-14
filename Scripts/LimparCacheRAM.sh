#!/bin/bash
# Desenvolvido por: Mário Augusto Paglia Junior
# Paglia Host Brasil: www.pagliahost.com.br
#
# Script para otimização de memória RAM
#
# Versões:
#
# 1.0 - 22/02/2018 - Desenvolvimento e criação do script

# Variáveis de Ambiente

RAM_TOTAL=$(free -m | grep "Mem:" | awk '{print $2}')
RAM_LIVRE=$(free -m | grep "Mem:" | awk '{print $4}')
RAM_VERIFICA=$(echo "$RAM_LIVRE/$RAM_TOTAL*100" | bc -l | cut -d "." -f1)

if [ "$RAM_VERIFICA" -lt "20" ]
then
	echo 3 > /proc/sys/vm/drop_caches
	sysctl -w vm.drop_caches=3
fi

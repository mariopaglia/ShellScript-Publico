#!/bin/bash
# Desenvolvido por: Mário Augusto Paglia Junior
# Paglia Host Brasil: www.pagliahost.com.br
#
# Script para analisar se existe processo ./xmr ativo no servidor e desligar
#
# Versões:
#
# 1.0 - 20/03/2018 - Desenvolvimento e criação do script

VERIFICA=$(ps ax | grep -v "grep" | grep "./xmr" | awk '{print $1}' | wc -l)
USUARIO=$(ps aux | grep -v "grep" | grep "./xmr" | awk '{print $1}')


if [ "$VERIFICA" -ge "1" ]
then
	ps ax | grep -v "grep" | grep "./xmr" | awk '{print $1}' | xargs kill -9

	echo -e "Caro administrador, foi o processo ./xmr foi encontrado ativo na conta '$USUARIO' e finalizado com sucesso" | mail -s "[VerificaProcesso_XMR.sh] Processo finalizado com sucesso" seu@email.com.br
fi

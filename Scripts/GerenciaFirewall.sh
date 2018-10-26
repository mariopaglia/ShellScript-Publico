#!/bin/bash
SHELL=/bin/sh
PATH=/sbin:/usr/sbin:/usr/bin:/bin
# Desenvolvido por: Mário Augusto Paglia Junior
# Paglia Host Brasil: www.pagliahost.com.br
##
# Script de Gerenciamento de Firewall

# Variáveis Globais

consulta=/etc/sysconfig/iptables
salvar=$( service iptables save > /dev/null )

# Variáveis de Cores

verde="\e[00;32m"		# Cor Verde: Entrada
vermelho="\e[00;31m"	# Cor Vermelho: Entrada
amarelo_e="\e[00;33m"	# Cor Amarelho: Entrada
cor_s="\e[00m"			# Saida de Cor: Original SHELL

# Menu de Opções

echo ""
echo "########## DIGITE UMA DAS OPÇÕES ABAIXO ##########"
echo ""
echo "[1] LIBERAR PORTA"
echo "[2] BLOQUEAR PORTA"
echo "[3] LIBERAR IP"
echo "[4] BLOQUEAR IP"
echo "[5] MUDAR REGRA PADRÃO"
echo ""
echo -n ">>> DIGITE A OPÇÃO DESEJADA: "
read opcao
echo ""

# Funções das opções escolhidas

case $opcao in
		1)
			echo ""
			echo -n " >>> DIGITE A PORTA QUE DESEJA LIBERAR: "
			read liberar_porta
			echo ""
			
			cat $consulta | grep "dport $liberar_porta"
			
			if [ $? = 1 ]
			then
				iptables -A INPUT -p tcp --dport $liberar_porta -j ACCEPT
				iptables -A INPUT -p udp --dport $liberar_porta -j ACCEPT
				$salvar
				echo ""
				echo -e "$verde PORTA $liberar_porta LIBERADA COM SUCESSO NO FIREWALL! $cor_s"
				echo ""
			else
				echo ""
				echo -e "$vermelho A PORTA $liberar_porta JÁ SE ENCONTRA LIBERADA NO FIREWALL, NADA À FAZER! $cor_s"
				echo ""
			fi
		;;
		2)
			echo ""
			echo -n " >>> DIGITE A PORTA QUE DESEJA BLOQUEAR: "
			read bloquear_porta
			echo ""
			
			iptables -D INPUT -p tcp --dport $bloquear_porta -j ACCEPT
			
			while [ $? = 0 ]
			do
				iptables -D INPUT -p tcp --dport $bloquear_porta -j ACCEPT
			done
			
			iptables -D INPUT -p udp --dport $bloquear_porta -j ACCEPT
		
			while [ $? = 0 ]
			do
				iptables -D INPUT -p udp --dport $bloquear_porta -j ACCEPT
			done
			$salvar
			echo ""
			echo -e "$verde A PORTA $bloquear_porta FOI BLOQUEADA COM SUCESSO! $cor_s"
			echo ""
		;;
		3)
			echo ""
			echo -n " >>> DIGITE O IP QUE DESEJA LIBERAR: "
			read liberar_ip
			echo ""
			
			cat $consulta | grep $liberar_ip
			
			if [ $? = 1 ]
			then
				iptables -A INPUT -s $liberar_ip -j ACCEPT
				$salvar
				echo ""
				echo -e "$verde O IP $liberar_ip FOI LIBERADO COM SUCESSO NO FIREWALL $cor_s"
				echo ""
			else
				echo ""
				echo -e "$vermelho O IP JÁ SE ENCONTRA LIBERADO NO FIREWALL, NADA À FAZER! $cor_s"
				echo ""
			fi
		;;	
		4)
			echo ""
			echo -n " >>> DIGITE O IP QUE DESEJA BLOQUEAR: "
			read bloquear_ip
			echo ""
			
			iptables -D INPUT -s $bloquear_ip -j ACCEPT
			
			while [ $? = 0 ]
			do
				iptables -D INPUT -s $bloquear_ip -j ACCEPT
			done
			$salvar
			echo ""
			echo -e "$verde O IP FOI REMOVIDO COM SUCESSO DO FIREWALL! $cor_s"
			echo ""
		;;	
		5)
			echo ""
			echo -n " >>> DIGITE A NOVA REGRA PADRÃO (ACCEPT OU DROP): "
			read regra_padrao
			echo ""
			
			iptables -P INPUT $regra_padrao
			$salvar
			echo ""
			echo -e "$verde A REGRA PADRÃO FOI ALTERADA COM SUCESSO PARA: $regra_padrao $cor_s"			
			echo ""
		;;	
						
esac		
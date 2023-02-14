#!/bin/bash
SHELL=/bin/sh
PATH=/sbin:/usr/sbin:/usr/bin:/bin
# Desenvolvido por: Mário Augusto Paglia Junior
# Paglia Host Brasil: www.pagliahost.com.br
##
# Comando de menus administrativos para VPS

clear
echo "###### DIGITE UMA DAS OPÇÕES ABAIXO ######"
echo ""
echo "[1] PARA TROCAR SENHA DO SSH E FTP"
echo "[2] PARA VERIFICAR ESPAÇO EM DISCO"
echo "[3] PARA LIMPAR O CACHE DA MEMÓRIA RAM"
echo "[4] PARA VERIFICAR OS ÚLTIMOS 10 ACESSOS À VPS"
echo "[5] PARA VERIFICAR O UPTIME (TEMPO DE VPS LIGADA)"
echo "[6] PARA VER QUEM ESTÁ ONLINE AGORA NA VPS (LOGADO)"
echo "[7] PARA VERIFICAR STATUS DO EMULADOR RAGNAROK (LIGADO OU DESLIGADO)"
echo "[8] PARA LIBERAR PORTA NO FIREWALL"
echo "[9] PARA REMOVER PORTA DO FIREWALL"
echo "[10] PARA VER OS TOP 10 PROCESSOS (CPU E RAM)"
echo ""
echo "PARA SAIR, DIGITE SAIR OU APERTE CTRL+C"
echo ""
echo -n ">>> Digite a opção desejada: "
read opcao

case $opcao in
	"1")
		echo ""
		echo -n " >>> Digite seu usuário: "
		read usuario

		echo -n " >>> Digite a nova senha: "
		read senha1

		echo -n " >>> Digite novamente a senha: "
		read senha2

	if [ $senha1 = $senha2 ]
	then
		 usermod -p $(openssl passwd -1 $senha1) $usuario
		echo ""
		echo -e "Você trocou a senha do usuário $usuario, agora sua nova senha é $senha1"
		echo ""
		echo ""
		echo "SALVE SUA SENHA EM UM LOCAL SEGURO"
		echo ""
	else
		echo ""
		echo "As senhas são diferentes, por favor, repita o procedimento"
		echo ""
	fi
;;
	"2")
		echo ""
		df -h
		echo ""
;;
	"3")
		echo 3 > /proc/sys/vm/drop_caches; free -m;
		echo ""
		echo "MEMÓRIA RAM OTIMIZADA COM SUCESSO!"
		echo ""
;;
	"4")
		echo ""	
		last | head
		echo ""
;;		
	"5")
		tempo_ligado=$( uptime | awk '{print $1}' )
		echo ""
		echo "A SUA VPS ESTÁ LIGADA HÁ: $tempo_ligado (DIAS / HORAS / MINUTOS / SEGUNDOS)"
		echo ""
;;		
	"6")
		echo ""
		who
		echo ""
;;
	"7")
		emulador_ligado=$( ps aux | grep -E "map-server|char-server|login-server" | wc -l )
	if [ $emulador_ligado -ge 3 ]
	then
		echo ""
		echo -e "O SEU EMULADOR ESTÁ \e[00;32mLIGADO\e[00m NO MOMENTO"
		echo ""
	else
		echo ""
		echo -e "O SEU EMULADOR ESTÁ \e[00;31mDESLIGADO\e[00m NO MOMENTO"
		echo ""
	fi	
;;	
	sair|Sair|SAIR)
		clear
		cd /home
;;
	"8")
		echo -n ">>> Digite a porta que deseja liberar: "
		read liberar_porta

		cat /etc/sysconfig/iptables | grep $liberar_porta
		
		if [ $? = 1 ]
		then
			iptables -I INPUT 1 -p tcp --dport $liberar_porta -j ACCEPT ;
			iptables -I INPUT 1 -p udp --dport $liberar_porta -j ACCEPT ;
			/etc/init.d/iptables save > /dev/null
			echo ""
			echo -e "PORTA \e[01;32mLIBERADA\e[00m COM SUCESSO! (TCP E UDP)"
			echo ""
		else
			echo ""
			echo "A PORTA INFORMADA JÁ ESTAVA LIBERADA NO FIREWALL!"
			echo ""
		fi	
;;		
	"9")
		echo -n ">>> Digite a porta que deseja remover: "
		read remover_porta
	
		iptables -D INPUT -p tcp -m tcp --dport $remover_porta -j ACCEPT
		
		while [	$? = 0 ]
		do
			iptables -D INPUT -p tcp -m tcp --dport $remover_porta -j ACCEPT
		done
		
		iptables -D INPUT -p udp -m udp --dport $remover_porta -j ACCEPT
		
		while [	$? = 0 ]
		do
			iptables -D INPUT -p udp -m udp --dport $remover_porta -j ACCEPT
		done
			echo ""
			echo -e "A PORTA FOI \e[00;31mREMOVIDA\e[00m COM SUCESSO! (TCP E UDP)"
			echo ""
			/etc/init.d/iptables save > /dev/null
;;
	"10")
		top | head -n 17
;;		
	*)
		echo "SELECIONE UMA DAS OPÇÕES DO MENU OU DIGITE: SAIR"
;;
esac

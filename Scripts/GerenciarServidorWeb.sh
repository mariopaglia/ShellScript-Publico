#!/bin/bash

VERIFICA=$(ps aux | grep -v "grep" | grep -E "apache2|mysql" | wc -l);

echo
echo "########## O QUE DESEJA FAZER? ##########"
echo
echo "1) Ligar Servidor Web"
echo "2) Reiniciar Servidor Web"
echo "3) Desligar Servidor Web"
echo

read -p "O que deseja fazer? " OPCAO

case $OPCAO in
    1)
        if [ $VERIFICA -ge "2" ]
        then
            echo "O Servidor Web já estava ligado!";
        else
            sudo service apache2 start;
            sudo service mysql start;
            echo "Servidor Web ligado com sucesso!";
        fi
    ;;

    2)
        if [ $VERIFICA -ge "2" ]
        then
            sudo service apache2 restart;
            sudo service mysql restart;
            echo "Servidor Web reiniciado com sucesso!";
        else
            echo "Houve algum problema ao reiniciar o Servidor Web";
        fi
    ;;

    3)
        if [ $VERIFICA -ge "2" ]
        then
            sudo service apache2 stop;
            sudo service mysql stop;
            echo "Servidor Web desligado com sucesso!";
        else
            echo "O Servidor Web já estava desligado!";
        fi
    ;;

    *)
        echo "Informe uma opção válida!";
    ;;
esac

$SHELL
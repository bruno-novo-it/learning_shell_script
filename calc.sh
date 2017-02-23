#!/bin/bash

###################################################################
# Script para realizar cálculos numéricos utilizando shell script #
# Feito por Bruno Luís e Elias Costa                              #
###################################################################

# Importando biblioteca de funções
source funcoes.sh

clear
## Menu de escolha ##
Menu()
  {
    echo -e "\n\n#############################"
    echo "##       CALCULADORA       ##"
    echo -e "#############################\n"
    echo " [ 1 ] SOMA "
    echo " [ 2 ] SUBTRAÇÃO "
    echo " [ 3 ] MULTIPLICAÇÃO "
    echo " [ 4 ] DIVISÃO "
    echo " [ 5 ] SAIR "
    echo -e "\n#############################\n"
    echo "Qual é a opção desejada?"
    read OPCAO
    clear

    ## Opções da calculadora ##
    case $OPCAO in
      1)soma;;
      2)subtracao;;
      3)multiplicacao;;
      4)divisao;;
      5)exit;;
    *)
    echo "Opção desconhecida !" ; echo ; Menu ;;
  esac
}
Menu

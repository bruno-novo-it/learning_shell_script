#!/bin/bash

###################################################################
# Base de funções para cálculos numéricos utilizando shell script #
# Feito por Bruno Luís, Elias Costa, Lucas Mucheroni              #
###################################################################


function soma(){
  echo -e "\n\n#############################"
  echo "##           SOMA          ##"
  echo -e "#############################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A soma dos dois valores é: $((first + second))"
  echo ""
  read -p "Pressione enter para continuar"
  clear
  Menu
}

function subtracao(){
  echo -e "\n\n#############################"
  echo "##        SUBTRAÇÃO        ##"
  echo -e "#############################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A subtração dos dois valores é: $((first - second))"
  echo ""
  read -p "Pressione enter para continuar"
  clear
  Menu
}

function multiplicacao(){
  echo -e "\n\n#############################"
  echo "##      MULTIPLICAÇÃO      ##"
  echo -e "#############################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A multiplicação dos dois valores é: $((first * second))"
  echo ""
  read -p "Pressione enter para continuar"
  clear
  Menu
}

function divisao(){
  echo -e "\n\n#############################"
  echo "##         DIVISÃO         ##"
  echo -e "#############################\n"
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A divisão dos dois valores é: $((first / second))"
  echo ""
  read -p "Pressione enter para continuar"
  clear
  Menu
}

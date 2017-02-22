#!/bin/bash

###################################################################
# Script para realizar cálculos numéricos utilizando shell script #
# Feito por Bruno Luís e Elias Costa                              #
###################################################################

# Importando biblioteca de funções
source funcoes.sh

# Opções da calculadora
case $1 in
  soma)
    soma
  ;;
  subtracao)
    subtracao
  ;;
  multiplicacao)
    multiplicacao
  ;;
  divisao)
    divisao
  ;;
  *)
    echo -e "\033[31;1m Necessário digitar alguma função. Ex: soma\033[m"
  esac

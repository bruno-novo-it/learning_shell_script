#!/bin/bash
source teste.sh


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

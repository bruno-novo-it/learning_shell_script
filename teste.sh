#!/bin/bash

###########################################
# Script diversos utilizando shell script #
# Feito por Bruno Luís e Elias Costa      #
###########################################


#echo $# # número total de argumentos na chamada do comando
#
#echo $* # Imprime todos os argumentos passados na chamada do comando(uma única string)
#
#echo $@ # Imprime todos os argumentos passados na chamada do comando mas protegidos(várias strings)

#TESTE=""

#if [ ! -z $TESTE ]; then
#  echo -e "\033[32;1mTeste não está Vazio \033[m"
#else
#  echo -e "\033[31;1mTeste está Vazio \033[m"
#fi

# Função que verifica se um valor está na sequencia de -1000 até 1000
function seq_valor(){
  echo "Digite um valor: "
  read valor
  for i in {-1000..1000}
  do
    if [ $i -eq $valor ]; then
    if [ $valor -le 0 ]; then
    echo "O valor digitado foi: $valor, e é menor que zero!"
  elif [ $valor -gt 0 ] && [ $valor -le 100 ]; then
    echo "O valor digitado foi: $valor e está na sequência de 0-100"
  elif [ $valor -gt 100 ]; then
    echo "O valor digitado foi: $valor e é maior que 100"
  fi
fi
  done
}

seq_valor

#echo “Testando o comando seq”
#  for i in $(seq 1 5 100);
#  do
#   echo "$i"
# done



# echo “Testando o loop for”
#    for i in {10..0};
#    do
#      echo "$i"
#    done

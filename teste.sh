#!/bin/bash

#echo $# # número total de argumentos na chamada do comando

#echo $* # Imprime todos os argumentos passados na chamada do comando(uma única string)

#echo $@ # Imprime todos os argumentos passados na chamada do comando mas protegidos(várias strings)

#TESTE=""

#if [ ! -z $TESTE ]; then
#  echo -e "\033[32;1mTeste não está Vazio \033[m"
#else
#  echo -e "\033[31;1mTeste está Vazio \033[m"
#fi

function soma(){
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A soma dos dois valores é: $((first + second))"
}

function subtracao(){
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A subtração dos dois valores é: $((first + second))"
}

function multiplicacao(){
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A multiplicação dos dois valores é: $((first * second))"
}

function divisao(){
  echo "Digite o primeiro valor: "
  read first
  echo "Digite o segundo Valor: "
  read second
  echo "A divisão dos dois valores é: $((first / second))"
}
#
#
#case $1 in
#  soma)
#    soma
#  ;;
#  subtracao)
#    subtracao
#  ;;
#  multiplicacao)
#    multiplicacao
#  ;;
#  divisao)
#    divisao
#  ;;
#  *)
#    echo -e "\033[31;1m Necessário digitar alguma função. Ex: soma\033[m"
#  esac


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

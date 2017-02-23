#!/bin/bash

###################################################################
# Base de funções para cálculos numéricos utilizando shell script #
# Feito por Bruno Luís e Elias Costa                              #
###################################################################


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
  echo "A subtração dos dois valores é: $((first - second))"
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

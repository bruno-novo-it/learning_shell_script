#!/bin/bash


#################################
# Populando e utilizando Arrays #
#################################

array_par=()
array_impar=()

function popula_array(){
while read LINE
do
  if [ "$(($LINE % 2))" -eq 0 ]; then
    array_par=("${array_par[@]}" "$LINE")
  else
    array_impar=("${array_impar[@]}" "$LINE")
  fi
done < popula_array.txt
}

function print_array_par(){
  echo -e "\n######### Array #########\n"
  for i in ${array_par[@]}
  do
    echo -e "Valor: $i"
  done
  # Mostra o Total de elementos
  echo -e "\nTotal de Elementos Pares: ${#array_par[@]}"
}

function print_array_impar(){
  echo -e "\n######### Array #########\n"
  for i in ${array_impar[@]}
  do
    echo -e "Valor: $i"
  done
  # Mostra o Total de elementos
  echo -e "\nTotal de Elementos Impares: ${#array_impar[@]}"
}


popula_array

print_array_par

print_array_impar

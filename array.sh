#!/bin/bash


#################################
# Populando e utilizando Arrays #
#################################

array=()

function popula_array(){
while read LINE
do
  if [ "$(($LINE % 2))" -eq 0 ]; then
    array=("${array[@]}" "$LINE")
  fi
done < popula_array.txt
}

function print_array(){
  echo -e "\n######### Array #########\n"
  for i in ${array[@]}
  do
    echo -e "Valor: $i"
  done
  # Mostra o Total de elementos
  echo -e "\nTotal de Elementos Pares: ${#array[@]}"
}

popula_array

print_array

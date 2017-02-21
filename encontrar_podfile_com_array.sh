#!/bin/bash

################################################################
# Script para encontrar e listar as dependencias de um arquivo #
# Podfile dentro do diretório (Workspace)                      #
################################################################

#PROJ_ROOT="$WORKSPACE";

MANDATORY=()
WHITELIST=()
DEPRECATED=()
BLACKLIST=()
NOT_FOUND=()

# Função para encontrar o Podfile e tratá-lo
function name(){
  cat $PODFILE | while read LINE
  do
    egrep "pod '.*'" \
    | tr ''\' '"' \
    | sed -e 's/^.*pod // ; s/$/,/ ; s/~>/~>","/ ; s/~</~<","/ ; s/ //g' \
    | tr '"' ' ' \
    | cut -d ',' -f1 >> dependencias.txt
  done
}

# Funcão para imprimir a MANDATORY
function print_MANDATORY(){
echo -e "\n######### MANDATORY #########\n"
    for i in ${MANDATORY[@]}
    do
      echo -e "Dependência: $i"
    done
    # Mostra o Total de elementos
    echo -e "\nTotal de Elementos: ${#MANDATORY[@]}"
}


# Funcão para imprimir a WHITELIST
function print_WHITELIST(){
echo -e "\n######### WHITELIST #########\n"
    for i in ${WHITELIST[@]}
    do
      echo -e "Dependência: $i"
    done
    # Mostra o Total de elementos
    echo -e "\nTotal de Elementos: ${#WHITELIST[@]}"
}

# Funcão para imprimir a DEPRECATED
function print_DEPRECATED(){
echo -e "\n######### DEPRECATED #########\n"
    for i in ${DEPRECATED[@]}
    do
      echo -e "Dependência: $i"
    done
    # Mostra o Total de elementos
    echo -e "\nTotal de Elementos: ${#DEPRECATED[@]}"
}

# Funcão para imprimir a BLACKLIST
function print_BLACKLIST(){
echo -e "\n######### BLACKLIST #########\n"
    for i in ${BLACKLIST[@]}
    do
      echo -e "Dependência: $i"
    done
    # Mostra o Total de elementos
    echo -e "\nTotal de Elementos: ${#BLACKLIST[@]}"
}

# Funcão para imprimir a NOT_FOUND
function print_NOT_FOUND(){
echo -e "\n######### NOT_FOUND #########\n"
    for i in ${NOT_FOUND[@]}
    do
      echo -e "Dependência: $i"
    done
    # Mostra o Total de elementos
    echo -e "\nTotal de Elementos: ${#NOT_FOUND[@]}"
}

# Encontra o Podfile e armazena na variável
PODFILE=$(find . -name Podfile)

if [ -z "$PODFILE" ]; then
  echo -e "\033[31;1mErro: Arquivo Podfile Não encontrado! \033[m";
  exit 0;
else
  echo -e "\033[32;1mVerificando Dependências... \033[m"

  name # Função para parsear o arquivo

  # Faz a comparação das Dependências do Projeto com a lista_dependencias.json
  while read LINE
  do
    if [ "$LINE" == `cat lista_dependencias.json | jq -r '.mandatory[].'\"$LINE\"'.name'` ]; then
      MANDATORY=("${MANDATORY[@]}" "$LINE")
    else
      if [ "$LINE" == `cat lista_dependencias.json | jq -r '.whitelist[].'\"$LINE\"'.name'` ]; then
        WHITELIST=("${WHITELIST[@]}" "$LINE")
      else
        if [ "$LINE" == `cat lista_dependencias.json | jq -r '.deprecated[].'\"$LINE\"'.name'` ]; then
          DEPRECATED=("${DEPRECATED[@]}" "$LINE")
        else
          if [ "$LINE" == `cat lista_dependencias.json | jq -r '.blacklist[].'\"$LINE\"'.name'` ]; then
            BLACKLIST=("${BLACKLIST[@]}" "$LINE")
          else
            NOT_FOUND=("${NOT_FOUND[@]}" "$LINE")
          fi
        fi
      fi
    fi
  done < dependencias.txt

  # Imprime as dependências em suas respectivas listas
  print_MANDATORY
  print_WHITELIST
  print_DEPRECATED
  print_BLACKLIST
  print_NOT_FOUND

  echo -e "\033[32;1mVerificação Concluída!!\033[m"
  rm -rf dependencias.txt
fi

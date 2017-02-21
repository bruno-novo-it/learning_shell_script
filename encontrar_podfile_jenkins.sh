#!/bin/bash

################################################################
# Script para encontrar e listar as dependencias de um arquivo #
# Podfile dentro do diretório (Workspace)                      #
################################################################

source util.sh
#
# Função principal: check_podfile
# Arquivos obrigatórios: Podfile, lista_dependencias.json
# Output gerado: ${WORKSPACE}/variables.properties
#

#############
# Functions #
#############

## Limpa variáveis e prepara arquivos temporários ##
function prepara_ambiente() {
  unset mandatory whitelist deprecated blacklist notfound
  unset list_mandatory list_whitelist list_deprecated list_blacklist list_notfound
  PODFILE=$(find . -name Podfile)
  LISTA_DP=$(find . -name lista_dependencias.json)
}

## Imprime quantas e quais libs encontradas no match ##
## $1= qntde | $2= lista | $3 identificador ##
function print_lib() {
  local re='^[0-9]+$' #regex verifica se é número em print_lib
  if [[ $1 =~ $re ]]; then
    # Verifica se tem mais de uma lib
    [ $1 -gt 1 ] && plural='s' || unset plural
    echo -e "\n"
    alerta g "$1 biblioteca$plural $3 encontrada$plural: $2"
  else
    echo -e "\n"
    alerta b "Nenhuma biblioteca $3 foi encontrada."
  fi
}

## Imprime libs encontradas que não estão na lista de classificação ##
## $1= qntde ##
function print_notfound() {
  [ $1 -gt 1 ] && plural='s' || unset plural
  echo -e "\n"
  alerta r "$1 biblioteca$plural sem categoria encontrada$plural: $2"
}

function print_lib_total(){
  alerta r "\n#### Listando Total de Dependências ####\n"
  [ -z $mandatory ] && mandatory=0
  echo "Mandatory:" $mandatory
  [ -z $whitelist ] && whitelist=0
  echo "Whitelist:" $whitelist
  [ -z $deprecated ] && deprecated=0
  echo "Deprecated:" $deprecated
  [ -z $blacklist ] && blacklist=0
  echo "Blacklist:" $blacklist
  [ -z $deprecated ] && notfound=0
  echo "Not Found:" $notfound
}

## Adiciona os valores na variável de ambiente do Jenkins ##
function inject_var() {
  $mandatory >> ${WORKSPACE}/variables.properties
  $whitelist >> ${WORKSPACE}/variables.properties
  $deprecated >> ${WORKSPACE}/variables.properties
  $blacklist >> ${WORKSPACE}/variables.properties
  $notfound >> ${WORKSPACE}/variables.properties
}

###############################
# Main Script - check_podfile #
###############################

## Valida se há arquivo de podfile ##
function check_podfile() {

  prepara_ambiente

  if [ -z "$PODFILE" ]; then
    alerta r "Erro: Arquivo Podfile não encontrado!";
    exit 1;
  elif [ -z "$LISTA_DP" ]; then
    alerta r "Erro: Arquivo lista_dependencias.json não encontrado!";
    exit 1;
  else
    # Gera uma lista de dependências, que está no Podfile do projeto
    alerta b "Verificando Dependências..."

    # cat PODFILE | egrep "pod '.*'" \
    #| tr ''\' '"' \
    #| sed -e 's/^.*pod // ; s/$/,/ ; s/~>/~>","/ ; s/~</~<","/ ; s/~=/~=","/ ; s/ //g' \
    #| tr '"' ' ' \
    #| cut -d ',' -f1

    # No OS X, a regex "[\s]+" que substitui espaço não existe, por isso, utilizamos "[[:space:]]+" que possui a mesma função
    cat $PODFILE | grep "pod '" | grep -v "#" | cut -d "," -f 1 | sed -E "s/[[:space:]]{1,10}pod [\'|’](.*)[\'|’]/\1/" > dependencias.tmp

    # Informa a dependências e retorna sua classificação (whitelist, blacklist,...)
    for LIB in `cat dependencias.tmp | sort | uniq`; do
      DP=$(cat lista_dependencias.json | jq --arg var "$LIB" -r '.classificacao | .[] | to_entries[] | .key as $k | .value | .[] |select(.name==$var) | $k')

      # incrementa a qntde e cria uma lista das libs.
      case $DP in
        mandatory)
          ((mandatory++))
          list_mandatory+=$"\n"${LIB}
        ;;
        whitelist)
          ((whitelist++))
          list_whitelist+=$"\n"${LIB}
        ;;
        deprecated)
          ((deprecated++))
          list_deprecated+=$"\n"${LIB}
        ;;
        blacklist)
          ((blacklist++))
          list_blacklist+=$"\n"${LIB}
        ;;
        *)
          ((notfound++))
          list_notfound+=$"\n"${LIB}
        esac
    done

    ## Total de libs encontradas
    print_lib_total

    ## Output da classificação das bibliotecas ##
    ## $1= qntde | $2= lista | $3 identificador ##
    print_lib "$mandatory" "$list_mandatory" "Mandatory"
    print_lib "$whitelist" "$list_whitelist" "Whitelist"
    print_lib "$deprecated" "$list_deprecated" "Deprecated"
    print_lib "$blacklist" "$list_blacklist" "Blacklist"
    print_notfound "$notfound" "$list_notfound"

    # Arquiva como variáveis de ambiente
    inject_var

    echo -e "\n"
    alerta g "Verificação Concluída!!"
  fi
}

check_podfile

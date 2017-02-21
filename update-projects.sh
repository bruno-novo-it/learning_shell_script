#!/usr/bin/env bash

if [[ -z "$1" || -z "$2" ]]; then
    echo " É necessário uma entrada. "
    exit 0
else
  echo "$1 $2" >> rtc-projects.txt
fi

# Export Jenkins variables
JENKINS_USER="bruno.novo"
JENKINS_TOKEN="c094b597639ce14544238486eff18eb3"
JENKINS_HOST="10.200.0.23"
JENKINS_PORT="8181"

# Função para obter o CRUMB (Permite realizar chamadas autenticadas na API do Jenkins)
function get_crumb(){
  CRUMB=$(curl -s 'http://'$JENKINS_USER':'$JENKINS_TOKEN'@'$JENKINS_HOST':'$JENKINS_PORT'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
  if [ -n "$CRUMB" ]; then
    return 0
  else
    echo -e "\033[0;31m## CRUMB não obtido ##\033[0m"
    return 1
  fi
}

# POST the new XML file
function post_xml_to_update_job() {
  GET_XML=`curl -w '%{response_code}' -H $CRUMB \
  http://$JENKINS_USER:$JENKINS_TOKEN@$JENKINS_HOST:$JENKINS_PORT/job/$j/config.xml \
  -o config.xml`
  if [[ -n "$GET_XML" && "$GET_XML" == 200 ]]; then
    LINE=`grep -nr '</a>' config.xml | cut -d':' -f2`
    awk -v "n=$LINE" -v "s=              $CONTENT" '(NR==n) { print s } 1' config.xml > new_config.xml
    mv new_config.xml config.xml
    echo -e "\033[0;33m## GET realizado com sucesso ##\033[0m"
  else
    echo "Não foi possível obter o XML do job"
  fi
  POST_XML=`curl -w '%{response_code}' -X POST -H $CRUMB \
  http://$JENKINS_USER:$JENKINS_TOKEN@$JENKINS_HOST:$JENKINS_PORT/job/$j/config.xml \
  --data-binary @config.xml`
  if [[ -n "$POST_XML" && "$POST_XML" == 200 ]]; then
    rm -rf config.xml
    echo -e "\033[0;33m## POST realizado com sucesso ##\033[0m"
  else
    echo -e "\033[0;31m## Não foi possível atualizar o job $j ##\033[0m"
    return 1
  fi
}

# Diff repos
DIF=`diff --changed-group-format='%>' --unchanged-group-format='' rtc-projects_backup.txt rtc-projects.txt`

# Condition for start script
if [ -z "$DIF" ]; then
  echo -e "\033[0;31m## Não há novos repositórios ##\033[0m"
  exit 0
else
  get_crumb
  diff --changed-group-format='%>' --unchanged-group-format='' rtc-projects_backup.txt rtc-projects.txt > rtc_projects_new.txt
  while read r
  do
    NEW_ITEM="$r"
    CONTENT='<string>'$NEW_ITEM'</string>'
    while read j
    do
      post_xml_to_update_job
    done < list_jobs.txt
  done < rtc_projects_new.txt

  rm -rf rtc_projects_new.txt
  rm -rf rtc-projects_backup.txt
  cp rtc-projects.txt rtc-projects_backup.txt
  git add .
  git commit -m "Adicionando mudanças"
  git push origin master
fi

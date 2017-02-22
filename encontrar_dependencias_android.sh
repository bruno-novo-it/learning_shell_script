#!/bin/bash

export ANDROID_HOME=/Users/brunonovo/Library/Android/sdk
echo $ANDROID_HOME

./gradlew -q projects | grep "Project '.*'" | tr ''\' ' ' | tr ':' ' ' | sed -e 's/.*Project // ; s/ //g' >> project_name.tmp

for PROJ in `cat project_name.tmp | sort`; do
  ./gradlew "$PROJ":dependencies | grep "\--- .*" | sed -e 's/'---'// ; s/'\|'// ; s/'\|'// ; s/'\|'// ; s/+// ; s/\\// ; s/'\('\*'\)'// ; s/ //g' >> project_dep.tmp
done

cat project_dep.tmp | sort | uniq >> project_dependencies.tmp

rm -rf project_name.tmp && rm -rf project_dep.tmp

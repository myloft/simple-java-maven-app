#!/usr/bin/env bash

echo '开源组件健康扫描 Demo'
echo

echo '项目扫描：'
b=''
i=0
while [ $i -le 100 ]
do
    printf "[%-50s] %d%% \r" "$b" "$i";
    sleep 0.1
    ((i=i+2))
    b+='#'
done
echo

echo
echo '项目版本：'
xmllint --xpath '/*[local-name()="project"]/*[local-name()="version"]/text()' ../../pom.xml

echo
echo
echo '开源组件：'
latest='4.12'
version=$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="dependencies"]/*[local-name()="dependency"]//*[local-name()="version"]/text()' ../../pom.xml)
printf "1. junit %s\n" "$version"
echo

echo '组件检查：'
b=''
i=0
while [ $i -le 100 ]
do
    printf "[%-50s] %d%% \r" "$b" "$i";
    sleep 0.05
    ((i=i+2))
    b+='#'
done
echo

if [ "$version" == "$latest" ]; then
    echo
    echo '项目通过健康扫描'
else
    printf "当前 junit 版本老旧，请升级至 %s\n" "$latest"
    echo '终止构建！'
    exit -1
fi
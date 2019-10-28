#!/usr/bin/env bash

apk update
apk add libxml2-utils
echo '开源组件健康扫描 Demo'
echo '(1/4) 项目版本：'
sleep 5
xmllint --xpath '/*[local-name()="project"]/*[local-name()="version"]/text()' $WORKSPACE/pom.xml
echo
echo '(2/4) 组件版本：'
sleep 5
latest='4.12'
version=$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="dependencies"]/*[local-name()="dependency"]//*[local-name()="version"]/text()' $WORKSPACE/pom.xml)
printf "1. junit %s\n" "$version"
if [ "$version" != "$latest" ]; then
    printf "版本老旧，请升级至junit %s\n" "$latest"
    echo '终止构建！'
    exit -1
fi
echo '(3/4) Liscence 检测：'
sleep 5
echo '无冲突'
echo '(4/4) 安全漏洞扫描：'
sleep 5
echo '未发现安全漏洞'

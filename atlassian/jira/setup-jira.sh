#/usr/bin/env bash

JIRA_PKG="atlassian-jira-software-8.15.0-x64.bin"

sudo apt -y install wget

cd /tmp && wget https://product-downloads.atlassian.com/software/jira/downloads/"${JIRA_PKG}"

wget "https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/jira/response.varfile"

chmod +x "${JIRA_PKG}"

sudo ./"${JIRA_PKG}" -q -varfile response.varfile


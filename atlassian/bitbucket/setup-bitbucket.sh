#!/usr/bin/env bash

BITBUCKET_PKG="atlassian-bitbucket-7.10.1-x64.bin"

sudo apt -y install wget

cd /tmp && wget "https://product-downloads.atlassian.com/software/stash/downloads/${BITBUCKET_PKG}"

wget "https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/bitbucket/response.varfile"

wget "https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/bitbucket/bitbucket.properties"

chmod +x "${BITBUCKET_PKG}"

sudo ./"${BITBUCKET_PKG}" -q -varfile response.varfile

sudo cp bitbucket.properties /var/atlassian/application-data/bitbucket/shared/



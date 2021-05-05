#!/usr/bin/env bash

BITBUCKET_PKG="atlassian-bitbucket-7.12.1-x64.bin"

sudo apt -y install wget fontconfig

# Install PostgreSQL if not already installed
which psql > /dev/null || bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh)"

cd /tmp && wget "https://product-downloads.atlassian.com/software/stash/downloads/${BITBUCKET_PKG}"

wget "https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/bitbucket/response.varfile"

wget "https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/bitbucket/bitbucket.properties"

chmod +x "${BITBUCKET_PKG}"

sudo ./"${BITBUCKET_PKG}" -q -varfile response.varfile

sudo cp bitbucket.properties /var/atlassian/application-data/bitbucket/shared/



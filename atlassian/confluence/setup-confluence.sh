#/usr/bin/env bash

CONFLUENCE_PKG="atlassian-confluence-7.12.2-x64.bin"

sudo apt -y install wget

cd /tmp

# PostgreSQL for Older versions of confluence.
#wget https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh
#chmod +x setup-postgres-for-atlassian.sh && ./setup-postgres-for-atlassian.sh --install-version 9.3

# Install PostgreSQL if not already installed
which psql > /dev/null || bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh)"

cd /tmp && wget https://product-downloads.atlassian.com/software/confluence/downloads/"${CONFLUENCE_PKG}"

wget "https://raw.githubusercontent.com/benny-sec/infra-config/main/atlassian/confluence/response.varfile"

chmod +x "${CONFLUENCE_PKG}"

sudo ./"${CONFLUENCE_PKG}" -q -varfile response.varfile

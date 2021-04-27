#!/usr/bin/env bash

BAMBOO_PKG="atlassian-bamboo-7.2.2.tar.gz"
BAMBOO_URL="https://Product-downloads.atlassian.com/software/bamboo/downloads/${BAMBOO_PKG}"
BAMBOO_INSTALL_DIR="/opt/atlassian/bamboo/"
BAMBOO_DATA_DIR="/var/atlassian/application-data/bamboo"

wget "${BAMBOO_URL}" -P /tmp

# Install PostgreSQL if not already installed
which psql > /dev/null || bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh)"

sudo mkdir -p "${BAMBOO_INSTALL_DIR}" && sudo tar -xC "${BAMBOO_INSTALL_DIR}" -f /tmp/${BAMBOO_PKG}

# get the full path to the bamboo installation by appending the bamboo package directory
BAMBOO_INSTALL_DIR="${BAMBOO_INSTALL_DIR}/${BAMBOO_PKG%.tar.gz}"

# create the bamboo home directory and update the config file to point to it. 
sudo mkdir -p "${BAMBOO_DATA_DIR}"
sudo sed -i "s%#bamboo.home=.*%bamboo.home=${BAMBOO_DATA_DIR}%g" ${BAMBOO_INSTALL_DIR}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties

sudo "${BAMBOO_INSTALL_DIR}"/bin/start-bamboo.sh


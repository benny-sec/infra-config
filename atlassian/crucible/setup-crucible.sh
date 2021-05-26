#!/usr/bin/env bash

CRUCIBLE_PKG="crucible-4.8.6.zip"
CRUCIBLE_URL="https://product-downloads.atlassian.com/software/crucible/downloads/${CRUCIBLE_PKG}"
CRUCIBLE_INSTALL_DIR="/opt/atlassian/crucible/"
CRUCIBLE_DATA_DIR="/var/atlassian/application-data/crucible"

sudo apt -y install wget unzip

# Set-up Oracle JDK 1.8
which java > /dev/null || bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-jdk.sh)"


# Install PostgreSQL if not already installed
which psql > /dev/null || bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh)"

wget "${CRUCIBLE_URL}" -P /tmp

sudo mkdir -p "${CRUCIBLE_INSTALL_DIR}" && sudo unzip /tmp/${CRUCIBLE_PKG} -d "${CRUCIBLE_INSTALL_DIR}"

# create the crucible home directory and update the env to point to it. 
sudo mkdir -p "${CRUCIBLE_DATA_DIR}"
FISHEYE_ENV="FISHEYE_INST=${CRUCIBLE_DATA_DIR}"
sudo bash -c "echo ${FISHEYE_ENV} >> /etc/environment"

sudo find "${CRUCIBLE_INSTALL_DIR}" -name "config.xml" -exec sudo cp {} "${CRUCIBLE_DATA_DIR}" \;

sudo find "${CRUCIBLE_INSTALL_DIR}" -name "start.sh" -exec {} \;

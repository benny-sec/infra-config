#!/usr/bin/env bash

FISHEYE_PKG="fisheye-4.5.1.zip"
FISHEYE_URL="https://product-downloads.atlassian.com/software/fisheye/downloads/${FISHEYE_PKG}"
FISHEYE_INSTALL_DIR="/opt/atlassian/fisheye/"
FISHEYE_DATA_DIR="/var/atlassian/application-data/fisheye"

sudo apt -y install wget unzip

# Set-up Oracle JDK 1.8
cd /tmp && wget https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-jdk.sh && chmod +x setup-jdk.sh
which java > /dev/null || ./setup-jdk.sh --install-version 1.8
# which java > /dev/null || bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-jdk.sh )"

# Install PostgreSQL if not already installed
wget https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh && chmod +x setup-postgres-for-atlassian.sh
which psql > /dev/null || ./setup-postgres-for-atlassian.sh --install-version 9.3 

wget "${FISHEYE_URL}" -P /tmp

sudo mkdir -p "${FISHEYE_INSTALL_DIR}" && sudo unzip /tmp/${FISHEYE_PKG} -d "${FISHEYE_INSTALL_DIR}"

# create the fisheye home directory and update the env to point to it. 
sudo mkdir -p "${FISHEYE_DATA_DIR}"
FISHEYE_ENV="FISHEYE_INST=${FISHEYE_DATA_DIR}"
sudo bash -c "echo ${FISHEYE_ENV} >> /etc/environment"

sudo find "${FISHEYE_INSTALL_DIR}" -name "config.xml" -exec sudo cp {} "${FISHEYE_DATA_DIR}" \;

sudo find "${FISHEYE_INSTALL_DIR}" -name "start.sh" -exec {} \;

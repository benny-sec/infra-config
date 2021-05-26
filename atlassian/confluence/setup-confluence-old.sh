#!/usr/bin/env bash

CONFLUENCE_PKG="atlassian-confluence-5.6.5-cluster.tar.gz"
CONFLUENCE_URL="https://product-downloads.atlassian.com/software/confluence/downloads/${CONFLUENCE_PKG}"
CONFLUENCE_INSTALL_DIR="/opt/atlassian/confluence/"
CONFLUENCE_DATA_DIR="/var/atlassian/application-data/confluence"
WORK_DIR="/tmp/conf"

echo_color() {
    case $1 in
        "red")
            echo "`tput setaf 1``tput bold`$2`tput sgr0`"
            ;;
        *)
            echo "`tput setaf 4``tput bold`$1`tput sgr0`"
            ;;
    esac
}


setup_dependencies() {

	mkdir -p "${WORK_DIR}" && cd "${WORK_DIR}"

	# Set-up Oracle JDK 1.7
	wget https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-jdk.sh
	chmod +x setup-jdk.sh && ./setup-jdk.sh --install-version 1.7
	
	## Set-up PostgreSQl 9.3
	wget https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-postgres-for-atlassian.sh
	chmod +x setup-postgres-for-atlassian.sh && ./setup-postgres-for-atlassian.sh --install-version 9.3

}

install_confluence() {
	wget "${CONFLUENCE_URL}" -P ${WORK_DIR}
	sudo mkdir -p "${CONFLUENCE_INSTALL_DIR}" && sudo tar -xC "${CONFLUENCE_INSTALL_DIR}" -f ${CONFLUENCE_PKG}
}

configure_confluence() {

	# get the full path to the confluence installation by appending the confluence package directory
	CONFLUENCE_INSTALL_DIR="${CONFLUENCE_INSTALL_DIR}/${CONFLUENCE_PKG%.tar.gz}"

	# create the confluence home directory and update the config file to point to it. 
	sudo mkdir -p "${CONFLUENCE_DATA_DIR}"
	sudo sed -i "s%# confluence.home=.*%confluence.home=${CONFLUENCE_DATA_DIR}%" ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/classes/confluence-init.properties

	# workaround for invalid filename for -Xlogcc 
	sudo sed -i "s/date +%F_%T/date +%F"/g ${CONFLUENCE_INSTALL_DIR}/bin/setenv.sh

}

main() {

	setup_dependencies

	echo_color "Installing: ${CONFLUENCE_PKG%.tar.gz}"

	install_confluence

	configure_confluence

	sudo "${CONFLUENCE_INSTALL_DIR}"/bin/start-confluence.sh
}

main "$@"


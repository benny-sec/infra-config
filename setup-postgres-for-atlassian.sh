#!/usr/bin/env bash

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

get_args() {
    while [[ $# -gt 0 ]]
    do
        key="$1"
        case $key in
            "--install-version")
                POSTGRES_VERSION="$2"
                shift # past argument
                shift # past value
                ;;
            --help|-h)
                print_usage
                exit 0
                ;;
            *)    # unknown option
                shift # past argument
                ;;
        esac
    done
}

set_install_params() {
    case $POSTGRES_VERSION in
        "9.3") # Java SE 1.7
            POSTGRES_VERSION="postgresql-9.3"
            ;;
        *)    # unknown option
            echo_color "red" "Defaulting to version postgresql-11"
            POSTGRES_VERSION="postgresql-11"
            ;;
    esac
}

install_postgresql() {

    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update && sudo apt-get -y install ${POSTGRES_VERSION}

}

create_db() {
    # Create the Jira user and a DB:
    sudo -u postgres psql -c "CREATE ROLE jirauser PASSWORD 'pass' NOSUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
    sudo -u postgres psql -c "CREATE DATABASE jiradb OWNER jirauser;"

    # Create the Confluence user and a DB:
    sudo -u postgres psql -c "CREATE ROLE confluenceuser PASSWORD 'pass' NOSUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
    sudo -u postgres psql -c "CREATE DATABASE confluencedb OWNER confluenceuser;"

    # Create the Bitbucket user and a DB:
    sudo -u postgres psql -c "CREATE ROLE bitbucketuser PASSWORD 'pass' NOSUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
    sudo -u postgres psql -c "CREATE DATABASE bitbucketdb OWNER bitbucketuser;"

    # Create the Bamboo user and a DB:
    sudo -u postgres psql -c "CREATE ROLE bamboouser PASSWORD 'pass' NOSUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
    sudo -u postgres psql -c "CREATE DATABASE bamboodb OWNER bamboouser;"

    # Create the Fisheye user and a DB:
    sudo -u postgres psql -c "CREATE ROLE fisheyeuser PASSWORD 'pass' NOSUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
    sudo -u postgres psql -c "CREATE DATABASE fisheyedb OWNER fisheyeuser;"

    # Create the Crowd user and a DB:
    sudo -u postgres psql -c "CREATE ROLE crowduser PASSWORD 'pass' NOSUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
    sudo -u postgres psql -c "CREATE DATABASE crowddb OWNER crowduser;"
}

print_usage()
{
    cat <<-EOF

    setup-postgres-for-atlassian.sh [--install-version 9.3]

    The script will install PostgreSQL 11 (by default) and creates the DB for atlassian products
    If the optional --install-version is specified the specified version is attempted.

    --install-version 9.3
        The PostgreSQL version to install.

    -h prints this text
EOF
}

main() {

    get_args "$@"
    set_install_params

    echo_color "Installing ${POSTGRES_VERSION} "

    install_postgresql
    create_db

    echo_color "Finished Installing ${POSTGRES_VERSION}"
}

main "$@"

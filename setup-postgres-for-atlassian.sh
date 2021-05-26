#!/usr/bin/env bash

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# postgresql for older versions of atlassian products (e.g Confluence 5.6.5)
# sudo apt-get update && sudo apt-get -y install postgresql-9.3
sudo apt-get update && sudo apt-get -y install postgresql-11

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




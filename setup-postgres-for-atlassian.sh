#!/usr/bin/env bash


# for bamboo
sudo apt-get update && sudo apt-get -y install postgresql-12

sudo -s -H -u postgres
# Create the Bamboo user:
createuser -S -d -r -P -E bamboouser
# Create the bamboo database:
createdb -O bamboouser bamboo
exit

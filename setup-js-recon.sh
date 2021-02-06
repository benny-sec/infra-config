#!/usr/bin/env bash

echo "Installing gau"
GO111MODULE=on go get -u -v github.com/lc/gau

echo "Installing fuff"
go get -u github.com/ffuf/ffuf

echo "Installng hakrawler"
go get github.com/hakluke/hakrawler

echo "Installing httpx"
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx

echo "Installing unfurl"
go get -u github.com/tomnomnom/unfurl

# debug info to ensure that all the tools are in-place
go env GOPATH | xargs -I % ls -alt %/bin

echo "Installing scripthunter"
DIR="${HOME}/workspace/tools" && mkdir -p "${DIR}" && cd "${DIR}" &&  git clone https://github.com/robre/scripthunter.git && cd "${DIR}"/scripthunter

echo "Done"

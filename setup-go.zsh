#!/usr/bin/env bash

GO_PKG="go1.15.8.linux-amd64.tar.gz" 

wget https://golang.org/dl/"${GO_PKG}" && sudo tar -C /usr/local -xzf "${GO_PKG}" && echo "export PATH=${PATH}:/usr/local/go/bin:${HOME}/go/bin">~/.oh-my-zsh/custom/go_path.zsh


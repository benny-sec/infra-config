#!/usr/bin/env bash

mkdir -p ~/workspace/tools

git clone https://github.com/hashicorp/terraform.git && cd terraform

# Install GO if not already installed
if ! command -v go &> /dev/null
then
        echo "GO could not be found, Installing it now..."
            bash -c "$(wget -O- https://raw.githubusercontent.com/benny-sec/infra-config/main/setup-go.zsh)"
                export PATH=${PATH}:/usr/local/go/bin:${HOME}/go/bin
fi

go install

terraform -install-autocomplete

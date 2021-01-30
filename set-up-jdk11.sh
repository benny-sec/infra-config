#!/usr/bin/env bash

JDK="jdk-11.0.10"
DEB="${JDK}_linux-x64_bin.deb"

wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/11.0.10+8/020c4a6d33b74f6a9d2bc6fbf189da81/$DEB

sudo dpkg -i $DEB

echo -n "export JAVA_HOME=/usr/lib/jvm/${JDK}\nexport PATH=$PATH:/usr/lib/jvm/${JDK}/bin">~/.oh-my-zsh/custom/java_path.zsh

sudo cp ~/.oh-my-zsh/custom/java_path.zsh /etc/profile.d/java_path.sh


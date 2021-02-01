#!/usr/bin/env bash

JDK="jdk-11.0.10"
DEB="${JDK}_linux-x64_bin.deb"

wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/11.0.10+8/020c4a6d33b74f6a9d2bc6fbf189da81/$DEB

sudo dpkg -i ${DEB}

echo -n "export JAVA_HOME=/usr/lib/jvm/${JDK}\nexport PATH=$PATH:/usr/lib/jvm/${JDK}/bin">~/.oh-my-zsh/custom/java_path.zsh

sudo cp ~/.oh-my-zsh/custom/java_path.zsh /etc/profile.d/java_path.sh

rm -rf ${DEB}

# TO-DO:  fix the alternative's configuration.
# Issue:  The system still uses Open JDK even after the Oracle JDK is installed.
#         the installation doesn't add the Oracle Java to the list of available alternatives and hence can't switch the java package to use. 
#     
# helper links: 
#              1.https://tech.lanesnotes.com/2008/03/using-alternatives-in-linux-to-use.html
#              2. https://askubuntu.com/questions/315646/update-java-alternatives-vs-update-alternatives-config-java 
#  ➜  ~ /usr/lib/jvm/jdk-11.0.10/bin/java --version
#  java 11.0.10 2021-01-19 LTS
#  Java(TM) SE Runtime Environment 18.9 (build 11.0.10+8-LTS-162)
#  Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.10+8-LTS-162, mixed mode)
#  ➜  ~ java --version
#  openjdk 11.0.9.1 2020-11-04
#  OpenJDK Runtime Environment (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04)
#  OpenJDK 64-Bit Server VM (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
#  ➜  ~ cat ~/.oh-my-zsh/custom/java_path.zsh
#                 export JAVA_HOME=/usr/lib/jvm/jdk-11.0.10\nexport PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/blackhawk/.fzf/bin:/usr/lib/jvm/jdk-11.0.10/bin:/usr/lib/jvm/jdk-11.0.10/bin% 



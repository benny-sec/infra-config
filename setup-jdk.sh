#!/usr/bin/env bash

# Java SE 7
#JDK="jdk1.7.0_80"
#PKG="jdk-7u80-linux-x64.tar.gz"
#URL=https://github.com/benny-sec/infra-config/raw/main/sw_backup/${PKG}


# https://www.oracle.com/java/technologies/javase-downloads.html
# Java SE 8
# JDK="jdk1.8.0_281"
# PKG="jdk-8u281-linux-x64.tar.gz"
# URL=https://github.com/benny-sec/infra-config/raw/main/sw_backup/${PKG}

# Java SE 11 (LTS)
JDK="jdk-11.0.10"
PKG="${JDK}_linux-x64_bin.tar.gz"
URL="https://download.oracle.com/otn-pub/java/jdk/11.0.10+8/020c4a6d33b74f6a9d2bc6fbf189da81/${PKG}"

# Java SE 15
# JDK="jdk-15.0.2"
# PKG="${JDK}_linux-x64_bin.tar.gz"
# URL="https://download.oracle.com/otn-pub/java/jdk/15.0.2%2B7/0d1cfde4252546c6931946de8db48ee2/${PKG}"

jinfo="/usr/lib/jvm/.${JDK}.jinfo"

wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" ${URL} -P /tmp


# for update-java-alternatives command
sudo apt-get -y install java-common

sudo mkdir -p /usr/lib/jvm && sudo tar -x -C /usr/lib/jvm -f /tmp/${PKG}

# Set-up environment for both bash and ZSH
# FixMe: This will be an issue when we manually switch the JDK version
# Maybe remove it from here and maintain as a small gist?
echo -e "export JAVA_HOME=/usr/lib/jvm/${JDK}">~/.oh-my-zsh/custom/java_home.zsh
sudo cp ~/.oh-my-zsh/custom/java_home.zsh /etc/profile.d/java_home.sh


# create a .jinfo file. 
# This is needed by the update-java-alternatives command to identify the JDK installations.   
cat <<EOF > /tmp/foo
name="Oracle-${JDK}
alias=Oracle-${JDK}
section=main
priority=1000

EOF

sudo mv /tmp/foo ${jinfo}

# create the symlinks using the update-alternatives command
# e.g /usr/bin/java -> /etc/alternatives/java -> /usr/lib/jvm/java-14-oracle/bin/java 
for c in $(ls /usr/lib/jvm/${JDK}/bin); do
    bin=/usr/lib/jvm/${JDK}/bin/$c
    sudo update-alternatives --install /usr/bin/$c $c ${bin} 1000
    sudo echo "jdkhl $c ${bin}" >>${jinfo}
done

# list available JDKs andd switch to the one installed above.
sudo update-java-alternatives -s ${JDK}
sudo update-java-alternatives -l

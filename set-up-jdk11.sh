#!/usr/bin/env bash

# https://www.oracle.com/java/technologies/javase-downloads.html
# Java SE 8
# JDK="jdk1.8.0_281"
# PKG="${JDK}-linux-x64.tar.gz" 
# URL=https://download.oracle.com/otn-pub/java/jdk/8u281-b09/89d678f2be164786b292527658ca1605/${PKG}

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

sudo apt-get -y install java-common

sudo mkdir -p /usr/lib/jvm

sudo tar -x -C /usr/lib/jvm -f /tmp/${PKG}

# Set-up environment for both bash and ZSH
echo -n "export JAVA_HOME=/usr/lib/jvm/${JDK}\nexport PATH=$PATH:/usr/lib/jvm/${JDK}/bin">~/.oh-my-zsh/custom/java_path.zsh
sudo cp ~/.oh-my-zsh/custom/java_path.zsh /etc/profile.d/java_path.sh

sudo cat <<EOF > /tmp/foo
name="Oracle-${JDK}
alias=Oracle-${JDK}
priority=100
section=main

EOF

sudo mv /tmp/foo ${jinfo}

for c in $(ls /usr/lib/jvm/${JDK}/bin); do
    bin=/usr/lib/jvm/${JDK}/bin/$c
    sudo update-alternatives --install /usr/bin/$c $c ${bin} ${priority}
    sudo echo "jdkhl $c ${bin}" >>${jinfo}
done

update-java-alternatives -s ${JDK}

update-java-alternatives -l

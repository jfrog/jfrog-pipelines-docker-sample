#!/bin/bash -e

echo "================= Adding some global settings ==================="
mkdir -p "$HOME/.ssh/"
mv /config "$HOME/.ssh/"
mv /90forceyes /etc/apt/apt.conf.d/
touch "$HOME/.ssh/known_hosts"
mkdir -p /etc/drydock

echo "================= Installing basic packages ================"
apt-get update
apt-get install -y \
sudo \
software-properties-common \
wget \
unzip \
curl \
openssh-client \
ftp \
gettext \
smbclient \
mercurial

echo "================= Installing Python packages =================="
apt-get install -q -y \
python-pip \
python2.7-dev

pip install -q virtualenv==16.7.0
pip install -q pyOpenSSL==19.1.0

export JQ_VERSION=1.5*
echo "================= Adding JQ $JQ_VERSION ========================="
apt-get install -y -q jq="$JQ_VERSION"

echo "================= Installing CLIs packages ======================"

export GIT_VERSION=1:2.*
echo "================= Installing Git $GIT_VERSION ===================="
add-apt-repository ppa:git-core/ppa -y
apt-get update -qq
apt-get install -y -q git="$GIT_VERSION"


JFROG_VERSION=1.33.2
echo "================= Adding jfrog-cli $JFROG_VERSION  ================"
curl -fL https://getcli.jfrog.io | bash -s v2
sudo chmod +x jfrog
mv jfrog /usr/bin/jfrog


#!/bin/bash

# see if this script has been run with sudo
if [ `whoami` = 'root' ]; then
    echo "run this script with sudo"
    exit 1
fi

# install packages
zypper in -y gcc zlib-devel readline-devel libbz2-devel libopenssl-devel sqlite3-devel docker

# set launch daemon on boot
systemctl enable docker

# install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
usermod -aG docker $USER && newgrp docker

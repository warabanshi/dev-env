#!/bin/bash

# see if this script has been run with sudo
if [ `whoami` != 'root' ]; then
    echo "run this script with sudo"
    exit 1
fi

# install packages
zypper in -y gcc zlib-devel readline-devel libbz2-devel libopenssl-devel sqlite3-devel docker

# set launch daemon on boot
echo "enable docker on boot"
systemctl enable docker

# install minikube
echo "install minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
usermod -aG docker $USER

# install kubectl
echo "install kubectl"
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl


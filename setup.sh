#!/bin/bash

if [ -f /etc/SUSE-brand ]; then
    OS=`head -1 /etc/SUSE-brand`
    VERSION=`tail -1 /etc/SUSE-brand | awk '{print $3}'`
fi

if [ -z ${OS} ] || [ -z ${VERSION} ]; then
    echo "appropriate version wasn't found"
    exit 1
fi

grep -E 'vmx|svm' /proc/cpuinfo > /dev/null
if [ $? -gt 0 ]; then
    echo "VT-s/AMD-V isn't turned on"
    exit 1
fi

CPU_COUNT=`cat /proc/cpuinfo | grep -i processor | wc | awk '{print $1}'`
if [ $CPU_COUNT -eq 1 ]; then
    echo "minikube needs at least 2 CPU"
    exit 1
fi

bash ./initialize/${OS}-${VERSION}.sh

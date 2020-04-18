#!/bin/sh
PACKERFILE=$GOPATH/$1
REQUIREMENTS=$GOPATH/requirements.txt
if [ -f "$REQUIREMENTS" ]; then
    ansible-galaxy install -r $REQUIREMENTS
else 
    AMI=$($GOPATH/bin/packer build -machine-readable $PACKER_FILE | awk -F, '$0 ~/artifact,0,id/ {print $6}')
    echo "::set-output name=ami::$tAMI"
fi

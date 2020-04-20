#!/bin/sh -l

# Validating if packer and ansible playbook exist
[ -z "$INPUT_PACKERFILE" ] && return 1 || echo "PACKER FILE = $INPUT_PACKERFILE"
[ -z "$INPUT_PLAYBOOKFILE" ] && return 1 || echo "PLAYBOOK FILE = $INPUT_PLAYBOOKFILE"

export PACKERFILE=$GOPATH/$INPUT_PACKERFILE
export PLAYBOOK=$GOPATH/$INPUT_PLAYBOOKFILE

echo "PACKER FILE = $PACKERFILE"
echo "PLAYBOOK FILE = $PLAYBOOK"

REQUIREMENTS=$GOPATH/requirements.txt
if [ -f "$REQUIREMENTS" ]; then
    ansible-galaxy install -r $REQUIREMENTS
else 
    AMI=$($GOPATH/bin/packer build -machine-readable $PACKER_FILE | awk -F, '$0 ~/artifact,0,id/ {print $6}')
    echo "::set-output name=ami::$AMI"
fi

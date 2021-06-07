#!/usr/bin/env bash

set -eux

export ANSIBLE_ROLES_PATH=../

# Test graceful failure for older versions of botocore
source virtualenv.sh
pip install 'botocore<1.10.57' boto3
ansible-playbook -i ../../inventory -v playbooks/version_fail.yml "$@"

# Run full test suite
source virtualenv.sh
pip install 'botocore>=1.10.57' boto3
ansible-playbook -i ../../inventory -v playbooks/full_test.yml "$@"

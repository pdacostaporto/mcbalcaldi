#!/bin/sh

ansible-galaxy install -r provision/requirements.yml
ansible-playbook -v
    -i provision/environments/production/hosts \
    provision/install.yml

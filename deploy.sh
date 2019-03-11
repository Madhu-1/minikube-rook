#!/bin/sh
vagrant destroy
vagrant  up

IP="$(grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory)"

sed -i "s/localhost/$IP/"  kubeconfig
export KUBECONFIG=kubeconfig

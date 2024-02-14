#!/bin/bash

is_vm_running() {
    virsh list --state-running | grep -q "$1"
    return $?
}

start_vm() {
    if ! is_vm_running "$1"; then
        echo "------- Starting $1 -------"
        virsh start "$1"
        while ! is_vm_running "$1"; do
            sleep 1
        done
        echo "------- $1 is up and running -------"
        sleep 5
    else
        echo "------- $1 is already running, skipping start -------"
    fi
}

start_vm k8s-nfs
start_vm k8s-controlplane
start_vm k8s-node-1
start_vm k8s-node-2
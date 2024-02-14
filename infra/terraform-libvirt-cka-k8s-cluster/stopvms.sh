#!/bin/bash

is_vm_running() {
    virsh list --state-running | grep -q "$1"
    return $?
}

shutdown_vm() {
    if is_vm_running "$1"; then
        echo "------- Shutting down $1 -------"
        virsh shutdown "$1"
        while is_vm_running "$1"; do
            sleep 1
        done
        echo "------- $1 has been shutdown -------"
    else
        echo "------- $1 is not running, skipping shutdown -------"
    fi
}

shutdown_vm k8s-controlplane
shutdown_vm k8s-node-1
shutdown_vm k8s-node-2
shutdown_vm k8s-nfs
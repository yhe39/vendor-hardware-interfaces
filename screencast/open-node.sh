#!/bin/bash

if [ -d "/sys/bus/pci/devices/0000:00:0d.0/" ] && [ -d "/sys/bus/pci/devices/0000:00:0e.0/" ]; then
    echo "VM1"
    echo "1af4 1110 8086 201" > /sys/bus/pci/drivers/ivshm_ivshmem/new_id
    chmod 666 /dev/ivshm0*
    echo "1af4 1110 8086 202" > /sys/bus/pci/drivers/ivshm_ivshmem/new_id
    chmod 666 /dev/ivshm1*
elif [ -d "/sys/bus/pci/devices/0000:00:0d.0/" ] && [ -d "/sys/bus/pci/devices/0000:00:10.0/" ]; then
    echo "VM2"
    echo "1af4 1110 8086 200" > /sys/bus/pci/drivers/ivshm_ivshmem/new_id
    chmod 666 /dev/ivshm0*
    echo "1af4 1110 8086 203" > /sys/bus/pci/drivers/ivshm_ivshmem/new_id
    chmod 666 /dev/ivshm1*
elif [ -d "/sys/bus/pci/devices/0000:00:0e.0/" ] && [ -d "/sys/bus/pci/devices/0000:00:10.0/" ]; then
    echo "VM3"
else
    echo "no ivshm config"
fi

if [ -d "/sys/bus/pci/devices/0000:00:0d.0/" ]; then
    # Set udmabuf list limit and change permissions
    echo 8192 > /sys/module/udmabuf/parameters/list_limit
    cat /sys/module/udmabuf/parameters/list_limit
    chmod 666 /dev/udmabuf

    # Create IPC directory and change permissions
    mkdir -p /data/local/ipc
    chmod 777 /data/local/ipc

    # Run the acrn-bkend-server in the background
    #./system/bin/acrn-bkend-server &
fi

#!/usr/bin/env bash

# SWAP

SWAP(){
    if [ -f '/mnt/2GiB.swap' ]; then
	echo true
    else
        dd if=/dev/zero of=/mnt/2GiB.swap bs=2048 count=1048576
        chmod 600 /mnt/2GiB.swap
        mkswap /mnt/2GiB.swap
        swapon /mnt/2GiB.swap
        echo '/mnt/2GiB.swap swap swap defaults 0 0' | sudo tee -a /etc/fstab
        cat /proc/sys/vm/swappiness

	echo '
####################################################################
# The default setting in Ubuntu is swappiness=60. Reducing the
# default value of swappiness will probably improve overall
# performance for a typical Ubuntu desktop installation.
#  Note: Ubuntu server installations have different performance
#   requirements to desktop systems, and the default value of 60
#   is likely more suitable.
vm.swappiness=40

#####################################################################
# https://www.ibm.com/docs/en/smpi/10.2?topic=mpi-tuning-your-linux-system
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_filter = 1
net.core.rmem_default = 1048576
net.core.rmem_max = 2097152
net.core.wmem_default = 1048576
net.core.wmem_max = 2097152' | sudo tee -a /etc/sysctl.conf
    fi
}

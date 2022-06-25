---
title: Automating running Debian in VirtualBox
date: 2013-07-16 14:22:47
tags: [linux, debian, virtualbox]
category: server
---

I'm experimenting with service separation by having each service run in
its own operating system, all of the sharing hardware though. Why ?
Separation seems to be the only secure approach to running any software.
Check [Joanna's](http://theinvisiblethings.blogspot.com/) blog out. I
went with VirtualBox on Debian 7 host, with, well, Debian 7 guests.
First I've prepared template VM by creating a new VM and just proceeding
with install. Then I tried spawning some clones of that, but having it
done manually takes quite some time  and is error prone. Did somebody
say automation ? Yes ! First, clone a VM, regenerating MAC addresses and
making sure the resource caps are good:

```
vmrunner@storage:~$ cat prepare_vm
#!/bin/bash
set -e
if [ $# -ne 2 ] ; then
    echo "usage: $0 vm_name vm_number"
    exit 0
fi

VM_NAME="$1"
RAM_AMOUNT="128"
DISK_SIZE="2000"
VM_NUMBER="$2"
RDP_PORT=$(($2+3389))
EXECUTION_CAP="50"

VBoxManage clonevm fresh.cyplo.net --name $VM_NAME --mode machine --register
VBoxManage modifyvm $VM_NAME --vrde on
echo "setting RDP listening port to $RDP_PORT"
VBoxManage modifyvm $VM_NAME --memory $RAM_AMOUNT
VBoxManage modifyvm $VM_NAME --vrdeport $RDP_PORT
VBoxManage modifyvm $VM_NAME --nic1 bridged --bridgeadapter1 eth0
VBoxManage modifyvm $VM_NAME --pae on
VBoxManage modifyvm $VM_NAME --cpuexecutioncap $EXECUTION_CAP
VBoxManage modifyvm $VM_NAME --hpet on
VBoxManage modifyvm $VM_NAME --hwvirtex on
VBoxManage modifyvm $VM_NAME --pagefusion on
VBoxManage modifyvm $VM_NAME --dvd none
VBoxManage modifyvm $VM_NAME --autostart-enabled on
VBoxManage modifyvm $VM_NAME --macaddress1 auto
VBoxManage modifyvm $VM_NAME --macaddress2 auto
echo "vm set up, listing all VMs:"
VBoxManage list vms
```

Then run the VM and change it into Debian
service host with new name and some software:

```
vmrunner@storage:~$ cat kickstart_debian
#/bin/bash
set -e
if [ $# -ne 2 ] ; then
    echo "usage: $0 new_hostname new_domainname"
    exit 0
fi

NEW_HOSTNAME="$1"
NEW_DOMAINNAME="$2"
NEW_FQDN="$NEW_HOSTNAME.$NEW_DOMAINNAME"
aptitude update
aptitude dist-upgrade -y
aptitude install vim atop sudo -y
hostname
ifconfig
set -v
echo "$NEW_FQDN" > /etc/mailname
echo "$NEW_HOSTNAME" > /etc/hostname
sed -i "s/dc_other_hostnames\='.*'/dc_other_hostnames='$NEW_FQDN'/g" /etc/exim4/update-exim4.conf.conf
sed -i "s/127\.0\.1\.1.*/127.0.1.1 $NEW_FQDN $NEW_HOSTNAME/g" /etc/hosts

rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
reboot
```

The script above needs to be run on guest, I'm using scp with known ssh keys to upload it and
then run via ssh. This step is to be automated in the future. Points to
improve:

- updating all the guests at once [Chef?]
- monitoring all guests at once [Nagios?]

Summarizing, I'm now running a Tor node, file server, caldav, carddav
and some other services on my home server. All of them in separate VMs.
And it's running quite well with 2GB of RAM. For more info on my home
server build check its
[hardware](/posts/2013/03/31/building-nas-hardware/) and basic
[software](/posts/2013/05/26/building-nas-software/).

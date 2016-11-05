SD cards are not really a reliable storage, especially when used
constantly e.g. while sitting in always powered-on Raspberry Pi. Because
of that I've recently needed to perform lots of backup/restore
operations ;) I wrote this script for backing up: 

.. code-block:: bash

    #!/bin/bash

    if [[ -z $1 ]]; then
        echo "usage: $0 device_to_clone"
        exit
    fi

    device=$1

    timestamp=`date +%Y%m%d`
    dest_file="/tmp/$timestamp.dd.xz"

    echo "about to clone $device to $dest_file"
    echo "ctrl-c or [enter]"
    read

    sudo umount $device?
    sudo umount $device

    sudo sync
    sudo pv -tpreb $device | dd bs=4M | pixz > $dest_file
    sudo sync

And this one for restoring:

.. code-block:: bash

    #!/bin/bash

    if [[ -z $1 ]] || [[ -z $2 ]]; then
        echo "usage: $0 restore_file.xz device_to_restore_to"
        exit
    fi

    source_file=$1
    if [[ ! -f $source_file ]]; then
        echo "cannot open $source_file"
        exit
    fi

    device=$2

    echo "about to restore $source_file onto $device"
    echo "ctrl-c or [enter]"
    read

    sudo umount $device?
    sudo umount $device

    pv -tpreb $source_file | pixz -d | sudo dd bs=4M of=$device
    sudo sync
    sudo eject $device

Some of the more fun features include progressbars and making sure you've unmounted the
device properly before ;) This also uses parallel threads to deflate the
data, so the XZ compression should not be a bottleneck on any modern
machine. The scripts above were used to backup and restore SD cards but
will work for any block device, be it an external or internal disk
drive, etc. usage example [remember to use the whole device, not just
its partition as an argument]: 

.. code-block:: console

    ./backup_sdcard /dev/sdc
    about to clone /dev/sdc to /tmp/20150214.dd.xz
    ctrl-c or [enter]

    [sudo] password for cyryl:
    umount: /dev/sdc1: not mounted
    umount: /dev/sdc2: not mounted
    umount: /dev/sdc: not mounted
    19,6MiB 0:00:02 [9,72MiB/s] [>                       ]  0% ETA 0:52:26

Operating system
^^^^^^^^^^^^^^^^

I think my NAS box build is no longer in much flux, so I thought it'd be
nice to describe it. I had some disks laying around, I had them
installed and started playing with the software setup. 

.. code-block:: 

    Disk /dev/sda:  60.0 GB,  60022480896 bytes
    Disk /dev/sdb: 320.1 GB, 320072933376 bytes
    Disk /dev/sdc: 160.0 GB, 160041885696 bytes
    Disk /dev/sdd: 250.1 GB, 250059350016 bytes
    Disk /dev/sde: 500.1 GB, 500107862016 bytes

First one is an SSD drive, I used it for OS
installation.  I went for `Crunchbang <http://crunchbang.org/>`__ as I
was already familiar with it, however now I'm thinking of just getting
newest Debian there, as it's finally released. Nothing fancy about the
OS, a regular install really. 

.. code-block:: 

    storage# df -h
    Filesystem                   Size  Used Avail Use% Mounted on
    rootfs                        53G  2.4G   48G   5% /
    /dev/sda1                    461M   31M  407M   7% /boot

As you can see / filesystem takes little amount
of space, hence the next thing I plan on doing is actually move / to
USB3.0 pendrive and then free the SATA drive from it's current duties.
I'm reluctant to do so right now, as moving swap to pendrive might
result in significant wear. I'm thinking of getting more RAM and then
getting rid of the swap at all. These stats were acquired after reboot,
there are some loads under which I saw swapping occur. 

.. code-block:: 

    storage# free -m
                 total       used       free     shared    buffers
    Mem:          1636        282       1354          0         53
    -/+ buffers/cache:        166       1470
    Swap:         1903          0       1903

Software + configuration
^^^^^^^^^^^^^^^^^^^^^^^^

NAS means SAMBA, right ? That's what I though. RAID5 + SAMBA for Win
clients and NFS for others. After a while I got accustomed to this setup
and started playing with my photo collection as it was laying on NAS.
The problem ? I deleted one photo and wanted it back. It was nowhere to
be found. RAID5, although having internal copies for resiliency, was
visible as one drive only and happily deleted the data when asked to.
What I really needed was a backup solution, not a NAS. My final answer
to that: 

.. code-block:: 

    storage# df -h
    Filesystem                   Size  Used Avail Use% Mounted on
    rootfs                        53G  2.4G   48G   5% /
    /dev/md0                     294G   36G  243G  13% /mnt/array_back
    /dev/sde1                    459G   35G  401G   8% /mnt/array_front

    storage# cat /etc/fstab
    #
    /dev/mapper/vg_storage-root                /               ext4    errors=remount-ro 0       1
    UUID=b9d32208-edc0-4981-ab74-5da1e7348a1a  /boot           ext4    defaults          0       2
    /dev/mapper/vg_storage-swap                none            swap    sw                0       0

    /dev/md0                                  /mnt/array_back  ext4    defaults          0       2
    /dev/sde1                                 /mnt/array_front ext4    defaults          0       2

    storage# mdadm --detail /dev/md0
    /dev/md0:
            Version : 1.2
      Creation Time : Sun Apr 21 22:47:38 2013
         Raid Level : raid5
         Array Size : 312318976 (297.85 GiB 319.81 GB)
      Used Dev Size : 156159488 (148.93 GiB 159.91 GB)

        Number   Major   Minor   RaidDevice State
           0       8       17        0      active sync   /dev/sdb1
           1       8       33        1      active sync   /dev/sdc1
           3       8       49        2      active sync   /dev/sdd1


One disk [sde] serves as a front for all user operations. After a while, all changes
except for deletions are being flushed onto [array_back] which is a
RAID5 matrix.


.. code-block:: 

    storage# cat /etc/cron.daily/90_sync_front_to_back
    #!/bin/bash
    rsync -avr /mnt/array_front/ /mnt/array_back/back

Secret sauce
^^^^^^^^^^^^

`ownCloud <http://owncloud.org/>`__. [array_front] is not directly
exposed via SAMBA or NFS, it's governed by ownCloud instance, and then
only ownCloud sync client on the computer or phone gets to mess with the
data. By having such setup I get 3 copies of each file. One on device,
one on the front array and one on the back array. What is also cool
about ownCloud is that it also handles contacts and calendar storage for
me. One more step towards getting all my data off google ! Points for
improvement:

-  [array_front] is not an array now. It's just a disk. Make it an
   proper disk array.
-  encrypt the data from array_back and send it to S3 and then let it
   graduate to Glacier


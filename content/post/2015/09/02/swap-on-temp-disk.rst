Some VPS providers, e.g. Azure (I know..) provide you with 2 disks for
your VPSes. One, of very limited size, system disk, and the other one,
spacy but with not guarantees that the data survives reboot. Basically
it means that you can have a small VPS, with a small amount of RAM but
large temp disk space. Why this could be useful ? Imagine tasks with
lots of mem requirements but that not need to be extra fast, where
swapping is allowed. Like complex nightly builds. Here is a set of super
simple scripts I've come up with to quickly boot up a system, and then
in the background add a new swap file on the temp drive there. The temp
drive is assumed to be under /mnt. 

.. code-block:: bash

	root@someazurehost:~# cat /etc/rc.local
	#!/bin/sh -e
	set -v

	# do not wait for swap to become online,
	# proceed with the boot further, 
	# with swap being created in the background
	/etc/make_and_enable_swap &

	exit 0

.. code-block:: bash

	root@someazurehost:~# cat /etc/make_and_enable_swap
	#!/bin/sh
	set -e
	set -v
	# create new 2GB swap file
	dd if=/dev/zero of=/mnt/swap bs=1M count=2048
	chmod 0600 /mnt/swap
	mkswap /mnt/swap
	swapon /mnt/swap

Don't forget to make **/etc/make_and_enable_swap** executable !
Do not add this swap file to fstab, as it is being read before rc.local,
and this may certainly result in a boot failure, as the swap file would
not be ready yet.

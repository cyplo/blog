---
title: Booting Gentoo with LUKS+LVM2+systemd
date: 2013-11-10 21:20:26
tags: [gentoo, linux, luks, systemd]
category: linux
---

I've spent quite some time recently trying to get a laptop running
Gentoo boot from an encrypted partition with LVM. I thought that this
might be useful for someone else, so here you are: First things first:
I'm assuming you've followed Gentoo handbook and are operating from
within livecd's shell. You've done the regular luksFormat + lvm stuff
and you've come up with a layout similar to this one:

```
dagrey ~ # lsblk
NAME                          SIZE TYPE  MOUNTPOINT
sda                           55.9G disk
└─sda1                        55.9G part
    └─crypthome (dm-3)          55.9G crypt /home
sdb                           29.8G disk
├─sdb1                       485.4M part  /boot
└─sdb2                        29.4G part
    └─root_sdb2-vg-root (dm-0)  29.3G crypt
    ├─vg-swap (dm-1)             8G lvm   [SWAP]
    └─vg-root (dm-2)          21.3G lvm   /
```

You need a kernel to boot this, a kernel that understands crypto stuff as well as
lvm.

`genkernel --symlink --save-config --no-mrproper --luks --lvm --udev --menuconfig all`

If you're using `gentoo-sources` you'll notice the fancy gentoo-specific menu on top. Go there and check
systemd. Apart from the usual stuff, please make sure to check stuff on
[this list](https://wiki.gentoo.org/wiki/Systemd), and also this one:

```
Device Drivers
    Multi-device support (RAID and LVM)
    [*] Multiple devices driver support (RAID and LVM)
    <*>  Device mapper support
    <*>  Crypt target support

Cryptographic API
    <*>  SHA256 digest algorithm
    <*>  AES cipher algorithms
```

Your setup is so new that you need grub2. Grub2 is very picky about its configuration. Take this one and
avoid hours of reading:

```
dagrey ~ # cat /etc/default/grub

GRUB_DISTRIBUTOR="Gentoo"

GRUB_DEFAULT=0
GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_TIMEOUT=3

GRUB_PRELOAD_MODULES=lvm
GRUB_CRYPTODISK_ENABLE=y
GRUB_DEVICE=/dev/ram0

# Append parameters to the linux kernel command line
GRUB_CMDLINE_LINUX="real_init=/usr/bin/systemd quiet real_root=/dev/mapper/vg-root crypt_root=/dev/sdb2 dolvm acpi_backlight=vendor"
```

You're using initrd to set everything up for the kernel, so you need `real_root` and `real_init` instead of
regular ones. `cryptdevice` no longer works, use `crypt_root` And
`dolvm` is essential, without it only the first part will work, leaving
you with open crypt container and kernel panic just afterwards. Also
notice `GRUB_DEVICE`, `GRUB_CRYPTODISK_ENABLE` and `GRUB_PRELOAD_MODULES`. Make sure the first partition on the disk you're
installing grub onto is starting at 2048. If it's any earlier grub just
won't be able to fit its magic in there. Finally, install grub

```
grub2-install --modules="configfile linux crypto search_fs_uuid luks lvm" --recheck /dev/sda
grub2-mkconfig -o /boot/grub/grub.cfg
```

That should be sufficient to boot the system and initialize root. What
about those other encrypted partitions like `/home` though ? Well, init
subsystem needs to initialize them, OpenRC did such by reading
`/etc/fstab` and then `/etc/dmcrypt/dmcrypt.conf` accordingly. Systemd is a
bit different here. You still need your `/etc/fstab` entries for it to
know which partitions need to be initialized. The place where you say
how to map and decrypt crypto containers, however, is in `/etc/crypttab.`

```
dagrey ~ # cat /etc/fstab

/dev/sdb1              /boot     ext2    defaults    1 2
/dev/mapper/vg-root    /         ext4    defaults    0 1
/dev/mapper/vg-swap    none      swap    sw          0 0
/dev/mapper/crypthome  /home     ext4    defaults    0 2

dagrey ~ # cat /etc/crypttab
#crypthome /dev/sda1
crypthome /dev/sda1 /etc/conf.d/dmcrypt.key
```

The keyfile is available from then already decrypted root partition. You can also skip the key and the
you'll get a password prompt, sometimes hidden somewhere in systemd messages. Hit enter to reveal it once more.

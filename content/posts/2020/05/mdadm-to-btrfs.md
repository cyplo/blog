---
title: Migrating from mdadm RAID1 to btrfs RAID1 on a live system
date: 2020-05-31
tags: [recipe]
---

I've managed to move from regular Linux software RAID1 to btrfs RAID1 without shutting the system down or losing any data and using only the disks already in the array.

Here's a note for my future self on how to do it, hope you, the dear reader, will find it useful as well.

I started with an mdadm array under `/dev/md127` , mounted as `/data`, consisting of two devices: `/dev/sdb1` and `/dev/sdc1`.
The first task is to remove one of those from the array while having the array still alive and retaining data.

```
umount /data
mdadm --fail /dev/md127 /dev/sdb1
mdadm --remove /dev/md127 /dev/sdb1
mdadm --zero-superblock /dev/sdb1
```

The last command above will prevent this disk from back popping into the array uninvited.

Let's create a new btrfs filesystem based on this one device.

```

```

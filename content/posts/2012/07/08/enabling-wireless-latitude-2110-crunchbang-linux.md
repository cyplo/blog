---
title: Enabling wireless on Dell Latitude 2110 under CrunchBang Linux
date: 2012-07-08 09:18:59
tags: [BCM43224, crunchbang, dell, linux]
category: linux
---

Update:
**Please note that I no longer host this kernel as it is very old and also Crunchbang is no more.**

Some time ago I got my hands on [CrunchBang Linux](http://crunchbanglinux.org/) distro, which is great. The only thing there that could be better is that my Broadcom BCM43224 WiFi card is not working. But I'm used to it, as many
Linux distros do not provide it. As I happen to
know from my Fedora experiences that it is resolved in kernel version
3.4 . Also as that kernel tends to be generally faster on my machine, I
decided to compile just this one. Here you are. [Vanilla 3.4.4](http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.4.4.tar.bz2)
kernel, [compiled](http://crunchbanglinux.org/forums/topic/18060/how-to-compile-the-kernel-from-source/)
for Intel Atom and with BCM43224 support. This is a 64bit kernel.
Download [crunchbanglinux-kernel-3.4.4-intel\_atom.tar.bz2]
and:

```
dpkg --remove firmware-linux
dpkg --remove firmware-linux-nonfree
tar jxf crunchbanglinux-kernel-3.4.4-intel_atom.tar.bz2
cd linux-3.4.4-intel_atom/
dpkg -i *.deb
reboot
```

Should work for Debian Squeeze also but not tested on that system. Email me if you'd
like it compiled any other way, e.g. for another processor.

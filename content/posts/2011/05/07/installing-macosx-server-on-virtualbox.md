---
title: Installing MacOSX Server 10.6 on VirtualBox
date: 2011-05-07 14:23:30
tags: [macosx, virtualbox]
categories: [freedom, mac, server]
---

It all started with my work assignment of installing MacOSX Server 10.6
on the XServe rack. Briefly speaking, after debugging some hardware problem
with the CPU temperature meter, I managed to install the base OSX server
system there. After that I needed to set up VMs with 10.6 64bit and 10.4 32bit
on top of that. Why so if already having 10.6 as the base system ?
Simply I wanted to avoid constant reinstallation of the base system, as
the machines are meant to be used for development and testing. Also the
XServe hardware was needed instead of classic blade system to meet Apple
license requirements. Having the internet read twice I decided to give
VirtualBox a try. My way of thinking was that I am already familliar
with that piece of software and know it as a easy to use one. In
addition to being pretty fool-proof it also enables features like operating from the commandline only. So what's the deal ?
Bring up VirtualBox GUI, click on new virtual machine creation button,
choose MacOSXServer, insert the iso file made from the installation dvd
and volia ? Not even remotely close. It appears that Apple has embedded
some kind of valid processors db into the system and checks the
processors present against it on every boot. The only configuration I managed to install
and launch was single-core. Both 32 and 64bit guests seem to be working
fine. But what's the point of having many cores there if only one can be
used per a VM ? Some time after that I found brilliant blog pair by
[prasys](http://prasys.info/) and
[nawcom](http://blog.nawcom.com/). It seems that the latter one
produces what's called [ModCD](http://blog.nawcom.com/?p=446) which
allows booting with the processor checks disabled. Recipe for amd64:

- create new MacOSX vm in VirtualBox
- change it to non-EFI type
- boot ModCD
- swap iso image for the one with the MacOS install
- press f5
- type -force64
- press enter

For me the installer crashed on the last step before reboot, but then it
rebooted successfully and continued on with the installation. Don't
forget to donate to nawcom if you can.

---
title: VPS adventures part one
date: 2010-10-24 23:40:32
tags: [dmehosting, server, ubuntu, virtualization, vps]
category: server
---

As every person in the software industry I need ways to promote my humble
self. A decent web page and online resume plus a blog maybe are a must
these days. The question remains where to put them.

Previously I had my site published within one of the polish hosting
companies for free, as my friend was involved in its operations. Thanks
[Kajetan](http://www.kajetanwandowicz.com/) for 5 years of support !
And maybe it'd stay that way if not of that desire of mine to tinker and
have control of every aspect of the technology power. Some platform with
ability to boot the system I want up would be appreciated.

Real servers are good when you have a place to put them. And want to pay
electricity bills, provide UPS, KVM, BGP and other three-letter
abbreviations. And oh, I simply don't like the fan noise
anymore. [VPS](http://en.wikipedia.org/wiki/Virtual_private_server)
then it is.

Since I recently made contact with Ubuntu Server edition and liked it
for its simplicity, I started searching for a cheap VPS which supports
the newest Ubuntu. Two googles later I found
[dmehosting.com](http://www.dmehosting.com/). 6$ for 25Gigs of space
and 256MB RAM seemed ok, so I bougth the VPS1 plan. Payment went without
problems, they support PayPal. With 6$ less on my account I was waiting
for them to give me the IP + login & password. I didn't expect that I
would take the whole day long.

My first contact with the machine was that of apt-get update, which
failed. Because of lack of network connectivity. I was logged by ssh to
that machine, so definitely some sort of connectivity had to be in
place. I dug into and found not working DNS servers, so I made VPS
connect to the other ones and everything started working. I jumped into
their 'live' tech support line just to hear that it was really bad of me
to change the resolv.conf and I just shouldn't do that. In the meanwhile
their DNSes went back so I in fact did revert the resolv.conf after all.

It's [OpenVZ](http://wiki.openvz.org/Main_Page>)-based hosting, so
policy of "no-no's" is pretty much embedded in the very system. No
kernel reinstallation. No swap space. No system clock write access. No
clicking too fast in the administration panel. Back to google then my search for VPS
is. Stay tuned for the next part.

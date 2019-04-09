---
title: WiFi on RaspberryPi
date: 2014-02-24 20:45:32
tags: [debian, raspberrypi]
---

Easiest way I've found to configure wifi on RaspberryPi, not really
being mentioned when you search for such. Not using separate
wpa_supplicant configuration at all.

```
root@frontend:~# cat /etc/network/interfaces
auto lo
iface lo inet loopback

iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-ssid  NETWORK_NAME
wpa-psk NETWORK_KEY

iface default inet dhcp
```

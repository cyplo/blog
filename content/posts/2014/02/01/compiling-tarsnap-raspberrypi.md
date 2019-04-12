---
title: Compiling tarsnap on RaspberryPi
date: 2014-02-01 21:59:27
tags: [raspberry pi, tarsnap]
---

Just a quickie for `tarsnap 1.0.35.` Featuring my new favourite, download software called aria2.

```
aptitude install aria2 libssl-dev zlib1g-dev e2fslibs-dev
aria2c https://www.tarsnap.com/download/tarsnap-autoconf-1.0.35.tgz
aria2c https://www.tarsnap.com/download/tarsnap-sigs-1.0.35.asc
gpg --recv-key 2F102ABB
gpg --decrypt tarsnap-sigs-1.0.35.asc
sha256sum tarsnap-autoconf-1.0.35.tgz # should get the value from sig file, 6c9f67....9a
tar xf tarsnap-autoconf-1.0.35.tgz
cd tarsnap-autoconf-1.0.35/
./configure
time nice ionice make -j2
```

How do I know that `-j2` really gives some advantage on raspi ? Well, here is the benchmark:

```
#fresh, j1
real    14m7.129s
user    6m30.790s
sys 0m21.640s

#-j2
real    11m33.868s
user    6m36.690s
sys 0m19.880s

#-j1 again, caches warmed up
real    12m38.598s
user    6m30.960s
sys 0m20.470s

#-j2 again
real    10m14.975s
user    6m34.980s
sys 0m20.710s
```

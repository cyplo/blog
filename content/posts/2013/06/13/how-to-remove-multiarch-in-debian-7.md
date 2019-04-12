---
title: How to remove multiarch in debian 7
date: 2013-06-13 09:04:37
tags: [debian, linux]
---

Just a quick one, for me to remember and for you to enjoy.

```
dpkg -l | grep :i386 | cut -s -d ' ' -f3 | xargs apt-get remove -y
dpkg --remove-architecture i386
apt-get update
```

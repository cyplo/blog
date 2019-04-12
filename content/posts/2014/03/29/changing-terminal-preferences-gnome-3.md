---
title: Changing Terminal preferences in Gnome 3 from the commandline
date: 2014-03-29 22:34:21
tags: [gnome3]
---

It turns out this was not that obvious, at least for me, how to change
various profile preferences for Gnome Terminal under Gnome 3 from the commandline. You can go
and fetch the list of profiles this way:

```
~# dconf list /org/gnome/terminal/legacy/profiles:/
:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/
```

And then you can use the profile id to list and change various settings:

```
~# dconf list /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/
foreground-color
login-shell
palette
use-system-font
use-theme-colors
font
bold-color-same-as-fg
bold-color
background-color
audible-bell

~# dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font "'Inconsolata for Powerline Medium 18'"
~# dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/login-shell true
```
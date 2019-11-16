---
title: Tools I use - 2019 edition
date: 2019-11-16
tags: [tools]
---

Here's a list of software I find useful, either things that I use daily or things that make an unusual task pleasant.
This is constantly evolving, so please mind the publish date of this post to gauge how dated it is. The best place to get most recent settings I currently use is my [dotfiles] repository, especially the [nixos] configuration.

## Laptop and OS

My daily driver is Thinkpad T480 running NixOS.
I like the hardware for its matte screen, nice keyboard and general sturdiness. It's also black and black is nice.

I use [home manager] to manage my dotfiles.
I still haven't found a good way of having all this setup ported exactly to non-NixOS operating systems.
Within the NixOS land I'm all set up now though, as an example -
I have an older laptop that I used previously, and installing NixOS there took total of around half an hour, giving me **exactly** the same look and feel to all the software I run as I'm used to.

NixOS's ability to boot into a previous version of the whole system is another big plus to me, as I like to experiment with my settings and sometimes I break something important. It creates an environment that does not punish you for trying something new, it encourages that.

## Internet router

I had a lot of problems with network speed over wifi previously, because of that I bought a [netgear xxx] router and installed [openwrt] on it. After all this change, I am able to run very frequent multi-gigabyte backup transfers over wifi and everything works nicely.

## Graphical interface

I started running i3 recently because of the strain Gnome3 was putting on my system, and I am liking it so far. There's polybar on top and not much else in terms of bells and whistles present.
I use autorandr to keep track of different display devices on different machines - it will automatically set the best resolution for whatever the screen combination I am currently using.

Firefox remains my browser of choice, I highly recommend you try it, it is so muc hfaster now than it used to be. Make sure to switch the tracking protection on.

## Secrets management

I have a veracrypt encrypted container, where my secrets reside, with a small set of scripts to [mount] and [unmount] it. The container is synced between different machines using syncthing.
Inside the container, among other things, there is a [password store] directory, which I use from either command line or from Firefox, using [plugin]

## Sync

Syncthing just keeps working, no matter how many devices I attach and what is their configuration. I run it on all my machines, including mobile devices and it just works.

## Backups

Here is where I am not that happy with the overall setup.
Currently I use [restic] to encrypt the backup and then ship it off of individual machines to my central NAS storage. Then from there it is being shipped to Backblaze's [b2] for off-site storage.

In principle, the setup I would like to retain, where the encryption credentials are only on machines creating backups and everything else only sees already encrypted files. In practice, restic itself seems to have a lot of troubles with the source machines being laptops and being constantly opened and closed, caused the running backup process to go through hibernation cycles. This locks/damages the central backup repo quite frequently and I need to run `restic rebuild-index` quite often to keep things working.

## Editors

I use a combination of vim, vscode and jetbrains IDEs for work. I like IDEs mostly for refactoring and debugging capabilities, while vim and vscode for speed of editing individual files. I still use vim-mode in IDEs though.

## Fonts

I settled on [Fira Code Retina] for most of my programming and terminal needs.

## Terminal

I find [termite] quite fast, while supporting extended character and colour sets.
My shell is [zsh] with minimal [omh-my-zsh config]. I always run it inside a [tmux] session though, and no matter how many terminal windows I open, I am always greeted with the same state. All history and window state is shared between all terminal windows all all tmux windows as well - it is always the same one tmux session. Because I am always running tmux, sometimes I end up in a situation when I ssh into some box and need to run tmux there - for that reason I have my main tmux session having different leader key than the defualt, this way I can choose which tmux session will receive my command - my machine or the one I'm connecting to.

Here's a small collection of other tools I found help a lot when on the terminal:

- [ripgrep] - it is just so much faster than grep
- [fd] - same but for `find`
- [bat] - a cooler `cat`
- [genpass] for generating passwords
- [z.lua] for faster navigation

---
title: My 2019 setup
date: 2019-11-16
series: my-setup
tags: [tools]
---

Here's a list of software and some hardware I find useful, either things that I use daily or things that make an unusual task pleasant instead of incredibly difficult.
This is constantly evolving, so please mind the publish date of this post to gauge how dated it is. The best place to get most recent settings I currently use is my [dotfiles](https://github.com/cyplo/dotfiles) repository, especially the [nixos](https://github.com/cyplo/dotfiles/tree/master/nixos) configuration.

## Laptop and OS

My daily driver is [Thinkpad T480](https://www.thinkwiki.org/wiki/Category:T480#Lenovo_ThinkPad_T480) running [NixOS](https://nixos.org/). I like the hardware for its matte screen, nice keyboard and general sturdiness. It's also black and black is nice.
The device-specific config lives [here](https://github.com/cyplo/dotfiles/blob/master/nixos/boxes/foureighty.nix).

I use [home manager](https://github.com/rycee/home-manager) to manage my dotfiles.
I still haven't found a good way of having all this setup ported exactly to non-NixOS operating systems.
Within the NixOS land I'm all set up now though, as an example -
I have an older laptop that I used previously, and installing NixOS there took total of around half an hour, giving me **exactly** the same look and feel to all the software I run as I'm used to.

NixOS's ability to boot into a previous version of the whole system is another big plus to me, as I like to experiment with my settings and sometimes I break something important. It creates an environment that does not punish you for trying something new, it encourages that.

## Networking gear

I had a lot of problems with network speed over wifi previously, because of that I bought a Netgear [Nighthawk X4S R7800](https://www.netgear.co.uk/home/products/networking/wifi-routers/R7800.aspx) router and installed [OpenWRT](https://openwrt.org/) on it. After all this change, I am able to run very frequent multi-gigabyte backup transfers over wifi and everything works nicely.

## Graphical interface

I started running [i3](https://i3wm.org/) recently because of the strain Gnome3 was putting on my system, and I am liking it so far, mostly for the speed of navigation and little resource usage. There's [polybar](https://github.com/polybar/polybar) on top and not much else in terms of bells and whistles present.
I use [autorandr](https://github.com/phillipberndt/autorandr) to keep track of different display devices on different machines - it will automatically set the best resolution for whatever the screen combination I am currently using. See [config](https://github.com/cyplo/dotfiles/blob/master/nixos/user-xsession.nix) for more details.

[Firefox](https://www.mozilla.org/en-GB/firefox/new/) remains my browser of choice, I highly recommend you try it, it is so much faster now than it used to be. Make sure to switch the tracking protection on.

## Secrets management

I have a [veracrypt](https://www.veracrypt.fr/en/Home.html) encrypted container, where my secrets reside, with a small set of scripts to [mount](https://github.com/cyplo/dotfiles/blob/master/tools/mount-vault) and [unmount](https://github.com/cyplo/dotfiles/blob/master/tools/umount-vault) it. The container is synced between different machines using [syncthing](https://syncthing.net/).
Inside the container, among other things, there is a [password store](https://www.passwordstore.org/) directory, which I use from either command line or from Firefox, using [this plugin](https://github.com/passff/passff)

## Sync

[Syncthing](https://syncthing.net/) just keeps working, no matter how many devices I attach and what is their configuration. I run it on all my machines, including mobile devices and it just works. This is how I keep all my documents, photos and other data always fresh between all devices. Just make sure to encrypt the data at rest when using it, you don't want to sync to a device which someone else can take from you and read all the data off of.
Sync is also not a replacement for backup, as file deletions and corruption can spread easily across your fleet.

## Backups

Here is where I am not that happy with the overall setup.
Currently I use [restic](https://restic.net/) to encrypt the backup and then ship it off of individual machines to my central NAS storage. Then from there it is being shipped to Backblaze's [b2](https://www.backblaze.com/b2/cloud-storage.html) for off-site storage.

In principle, the setup I would like to retain, where the encryption credentials are only on machines creating backups and everything else only sees already encrypted files. In practice, restic itself seems to have a lot of troubles with the source machines being laptops and being constantly opened and closed, caused the running backup process to go through hibernation cycles. This locks/damages the central backup repo quite frequently and I need to run `restic rebuild-index` quite often to keep things working.

For this reason I started working on [bakare](https://github.com/cyplo/bakare), a small backup engine in Rust - [let me know](mailto:bakare@cyplo.net) if you would be interested in collaborating with me on it.

## Editors

I use a combination of [vim](https://www.vim.org/), [VSCode](https://code.visualstudio.com/) and different [JetBrains'](https://www.jetbrains.com/) IDEs for work. I like IDEs mostly for refactoring and debugging capabilities, while vim and VSCode for speed of editing individual files. I still use vim-mode in IDEs though.

## Fonts

I settled on [Fira Code Retina](https://github.com/tonsky/FiraCode) for most of my programming and terminal needs.

## Terminal

I find [termite](https://github.com/thestinger/termite) quite fast, while supporting extended character and colour sets.
My shell is [zsh](https://www.zsh.org/) with minimal [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) [config](https://github.com/cyplo/dotfiles/blob/master/nixos/programs/zsh.nix). I always run it inside a [tmux](https://github.com/tmux/tmux/wiki) session though, and no matter how many terminal windows I open, I am always greeted with the same state. All history and window state is shared between all terminal windows all tmux windows as well - it is always the same one tmux session. Because I am always running tmux, sometimes I end up in a situation when I ssh into some box and need to run tmux there - for that reason I have my main tmux session having different leader key than the default, this way I can choose which tmux session will receive my command - my machine or the one I'm connecting to. All of the above comes from a combination of [shell](https://github.com/cyplo/dotfiles/blob/master/nixos/programs/zsh.nix) and [tmux](https://github.com/cyplo/dotfiles/blob/master/nixos/programs/tmux.nix) settings.

Here's a small collection of other tools I found help a lot when on the terminal:

- [ripgrep](https://github.com/BurntSushi/ripgrep) - it is just so much faster than grep
- [fd](https://github.com/sharkdp/fd) - same but for `find`
- [bat](https://github.com/sharkdp/bat) - a cooler `cat`
- [genpass](https://crates.io/crates/genpass) for generating passwords
- [z.lua](https://github.com/skywind3000/z.lua) for faster navigation

And that's it !
I hope you'll find this list useful and do not hesitate to [contact me](mailto:blog@cyplo.net) on `blog@cyplo.net` if you would have any questions or comments. Happy hacking !

---
title: My 2020 setup
date: 2020-12-29
series: my-setup
tags: [tools]
---

Hello and welcome to the second edition of me doing a summary of the year of using tech tools.

Here's a list of software and some hardware I find useful, either things that I use daily or things that make an unusual task pleasant instead of incredibly difficult.
This is constantly evolving, so please mind the publish date of this post, please also check the [last year's installment](https://blog.cyplo.dev/posts/2019/11/tools/) as this article will make references to the previous setup.

## Laptop, OS and other work hardware

- [Thinkpad T480](https://www.thinkwiki.org/wiki/Category:T480#Lenovo_ThinkPad_T480), the device-specific config lives [here](https://git.sr.ht/~cyplo/dotfiles/tree/master/item/nixos/boxes/foureighty/default.nix).
- CalDigit TS3 Plus usb-c hub
- Iiyama ProLite 27" 4K monitor
- IKEA BEKANT motorised standing desk

No dramatic changes here since the [last year](https://blog.cyplo.dev/posts/2019/11/tools/), I'm still on [NixOS](https://nixos.org/) on the T480. Thinkpad got a RAM upgrade to 48GiB and is handling it well, despite it being above it stated memory limit. I've also managed to get my `home-manager` config [called](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/boxes/foureighty/default.nix#L33) from the main system configuration, so now I just need to do `sudo nixos-rebuild switch --upgrade` once and it does my `home-manager` setup as well. This allowed me to split the config into modules a bit better.

I'm really happy with the standing desk as it allows me to switch from sitting to standing and back very quickly.

For the USB-C hub, I switched from the StarTech one I had before and this one is much more stable now.

### TODOs for 2021:

- to look into [`flakes`](https://nixos.wiki/wiki/Flakes) and see if I want to port my config over to that style.

## Networking

- [Turris Omnia](https://www.turris.com/en/omnia/overview/)
- [Devolo Magic 2 WiFi](https://www.devolo.co.uk/magic-2-wifi) powerline adapters

While I stopped having WiFi speed problems with the purchase of the Netgear R7800 router, it started dropping packets in the summer. I suspect it started overheating, whether it was solely a problem with the hardware itself or was also influenced by where the router was placed and the airflow avaiable I don't know. As I needed this solved quickly I bought Turris Omnia as a replacement and am quite happy with it.

### TODOs for 2021:

- debug the overheating problem
- try to port [NixWRT](https://github.com/telent/nixwrt) to run on R7800

## Graphical interface

- [i3](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/i3)
- [grobi](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/i3/grobi.nix)

Running `grobi` now instead of `autorandr` but otherwise the config seems to be stabilising.

## Secrets management

- [veracrypt](https://www.veracrypt.fr/en/Home.html) + [syncthing](https://syncthing.net/)
- [password store](https://www.passwordstore.org/) + [passff](https://github.com/passff/passff)
- [bitwarden](https://bitwarden.com/)

I have a `veracrypt` encrypted container, where my secrets reside, with a small set of scripts to [mount](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/tools/mount-vault) and [unmount](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/tools/umount-vault) it. The container is synced between different machines using `syncthing`.
Inside the container, among other things, there is a `password store` directory, which I use from either command line or from Firefox.

For when I need to share a secret I use `bitwarden` as it allows for that in a quite an easy way.

## Sync

[Syncthing](https://syncthing.net/) just keeps working, no matter how many devices I attach and what is their configuration. I run it on all my machines, including mobile devices and it just works. This is how I keep all my documents, photos and other data always fresh between all devices. Just make sure to encrypt the data at rest when using it, you don't want to sync to a device which someone else can take from you and read all the data off of.
Sync is also not a replacement for backup, as file deletions and corruption can spread easily across your fleet.

## Backups

- [restic](https://restic.net/)

Here is where I am not that happy with the overall setup, and not that much has changed from 2019.
Currently I use `restic` to package and encrypt the backup and then ship it off of individual machines to my central NAS storage. Then from there it is being copied to Backblaze's [b2](https://www.backblaze.com/b2/cloud-storage.html) for off-site storage.

I made some progress on [bakare](https://github.com/cyplo/bakare), a small backup engine in Rust, but it's not ready for production use yet. [Let me know](mailto:bakare@cyplo.net) if you would be interested in collaborating with me on it.

### TODOs for 2021:

- finish bakare ?

## Editors

- vim [configured via nix](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/home-manager/programs/vim.nix)
- VSCode [also configured via nix](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/gui/vscode.nix)

Not much of a change here.

## Fonts

I settled on [Fira Code Retina](https://github.com/tonsky/FiraCode) for most of my programming and terminal needs.

## Terminal

- [kitty](https://sw.kovidgoyal.net/kitty/) and [my config](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/home-manager/programs/kitty.nix) for it
- [zsh](https://www.zsh.org/) + [config](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/home-manager/programs/zsh.nix)
- [tmux](https://github.com/tmux/tmux/wiki) + [config](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/home-manager/programs/tmux.nix)

While I still like `termite` and `alacritty`, I have switched to `kitty` lately as it is still quite fast while providing for some fancy shenanigans like graphics in the terminal. I'm not fully happy with my setup yet, as, for example, kitty sometimes requires restart for the graphics feature to work.

Here's a small collection of other tools I found help a lot when on the terminal:

- [newsboat](https://newsboat.org/) - a new one on the list, I find it providing a cool and relaxing way of reading RSS in the terminal, see [here](https://git.sr.ht/~cyplo/dotfiles/tree/83ddcc09dc68389b129d598722eca9e90a6dff33/item/nixos/home-manager/programs/newsboat.nix) for my config, including my subscriptions list
- [ripgrep](https://github.com/BurntSushi/ripgrep) - it is just so much faster than grep
- [fd](https://github.com/sharkdp/fd) - same but for `find`
- [bat](https://github.com/sharkdp/bat) - a cooler `cat`
- [genpass](https://crates.io/crates/genpass) for generating passwords
- [z.lua](https://github.com/skywind3000/z.lua) for faster navigation

### TODOs for 2021:

- make `kitty`'s image mode always work out of the box

## Code hosting

I'm trying to migrate off of GitHub, I'm trying out [sr.ht](https://sr.ht/) now. I like its simplicity and ease of setup, especially when it comes to the built-in CI.

## The end

And that's it !

I hope you'll find this list useful and do not hesitate to [contact me](mailto:blog@cyplo.net) on `blog@cyplo.net` if you would have any questions or comments. Happy hacking !

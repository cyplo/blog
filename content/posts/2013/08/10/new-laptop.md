---
title: New laptop
date: 2013-08-10 10:45:20
tags: [linux, hardware]
category: hardware
---

Hey, remember my [search for the new laptop](/posts/2013/01/15/laptop-would-love-to-buy/) ?
It's finally over ! I found that Clevo, Taiwanese custom laptop
manufacturer, has recently added 13'3 FullHD laptop base to their
offerings - W230ST. And to my surprise - there is a [Polish importer](http://www.bluemobility.pl/) which allows pretty neat specs
calibration for you. Game on you say ? Indeed.

## What I like about it:

- Haswell-based, so all the new tech is here, same as in the newest
  MacBooks
- up to 16GB RAM, I have 8GB installed for now and it works pretty good
- 2x mPCIx mSATA capable slots
- nice copper cooling inside
- FullHD matte display
- 4x USB
- HDMI
- typing on its keyboard, just clicks with me
- survived [OHM2013](https://ohm2013.org/site/) camp - not scared of
  humidity and hot air

## What I do not like so much:

- Haswell-based, so Linux support is not that great yet, everything
  seems to be working okay, however power consumption is off the
  limits. 60Wh battery lasts for ~2h tops.
- while the outer side of the case is of nice rubberrized plastic, the
  inside is cheap-looking grey one. There was no option to change it
  unfortunately, while I see that [other](http://www.xoticpc.com/)
  importers/assemblers around the world have such mods avaiable.
- the looks of the keyboard, purely visual stuff like the font used to
  print the characters, the layout is okay

## Running Linux on it:

Everything seems to be working by default on
most of the distros. I've tested Gentoo, Arch, Fedora and Crunchbang.
The only thing that needed some tweaking was that by default I was
unable to control backlight brightness at all. Adding `acpi_backlight=vendor` to the kernel boot parameters, as suggested
on [Arch wiki](https://wiki.archlinux.org/index.php/Intel_Graphics#Backlight_not_fully_adjusting.2C_or_adjusting_at_all_after_resume.),
solved the problem. I haven't delved deeply into Optimus yet, so I don't
know whether the graphics cards switching works correctly or not. The
one thing I've noticed is that, after waking from deep sleep, so after
leaving the lid closed for a long time, not for few minutes, there are
some visual artifacts on screen. Also, as mentioned before, power
consumption worries me a bit. Will keep you posted !

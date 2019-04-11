---
title: The best terminal emulator for Windows 10's Bash or how to run X applications
date: 2016-07-06 19:21:13
tags: [windows]
---

**update as of 03/2017**

As this article is by far the most popular on my site right now I feel that an update is necessary, as the landscape evolved a bit since the original publish date.
[Conemu](https://conemu.github.io/) started to support Bash on Windows properly now and this is what I settled on in the end.
The article below is still relevant for _the running X applications on Windows_ part though.

---

I've been playing a bit with
[GNU/kWindows](https://mikegerwitz.com/2016/04/GNU-kWindows) a.k.a.
Bash on Windows a.k.a Windows Subsystem for Linux (Beta). I was
especially interested whether I can use my regular Linux
[dotfiles](https://github.com/cyplo/dotfiles/) to recreate my working
environment of zsh + tmux + vim. The biggest troubles I had were with
the terminal emulator. While the default one, invoked by saying **bash**
is much better than powershell or cmd.exe already - it lacks some things
I've learned to rely on, like 256-colour palette support. Thus the
search for the ultimate terminal emulator begun. I tried **ConEmu**,
**cmder** and their spinoffs to no avail. Either the colours were
lacking, or the emulator would swallow up certain strokes like the arrow
keys. Then I thought - hey, I use **terminator** on Linux, maybe it
would be possible to use it here as well. To my surprise the answer was - yes !

- install Windows Subsystem for Linux
- restart Windows
- install [VcXsrv](https://sourceforge.net/projects/vcxsrv)
- run VcXsrv
- invoke the following from the bash console:

```
sudo apt-get install terminator
DISPLAY=:0 terminator -u
```

- profit !

{{< figure src="capture.png" postition="center" >}}

The font rendering is not ideal and the borderless mode does
not work, but hey, it is quite usable nonetheless ! It even has
bidirectional clipboard sharing with Windows' windows, which is good.
P.S. konsole and gnome-terminal do seem to have troubles launching
(crashy-crashes there)

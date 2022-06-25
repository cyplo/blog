---
title: Speeding up Eclipse/Aptana
date: 2011-05-23 12:29:49
tags: [aptana, eclipse, java]
category: open source
---

As you know Aptana is Eclipse. And Eclipse is a Java-based IDE
which means it's not particularly a speedy one. However if you have a
decent amount of ram, like 4gb, it's fairly easy to speed the Eclipse
up. Find `eclipse.ini` or `aptana.ini` or other file which
contents look similar. These settings are from my Linux box - I know that
MacOS can get scared by higher values there; if you encounter any problems - try lowering the `Xmx`
and/or others.

```
--launcher.XXMaxPermSize
512m
--launcher.defaultAction
openFile
-vmargs
-Xms128m
-Xmx2048m
```

These settings are for the 4gb ram box, try to find the ones which suit you best. `MaxPermSize`
stands for the maximum amount of the memory to be used by the Java
internals, `Xms` gives the amount of heap allocated on the VM start and
`Xmx` is the heap size limit. Start by upping `Xms` value as it's often
too small which causes the Java VM to make lots of heap resizes on the
app start.

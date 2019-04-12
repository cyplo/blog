---
title: Compiling git 2.0 on cygwin
date: 2014-07-05 10:06:59
tags: [cygwin]
---

I had some troubles compiling git 2.0 under cygwin. I present you with a
very dirty hack to do so. Proper patch will probably follow. Did I
mention that the hack is dirty and will make your hands burn if you're
gonna type it in ?

```
git clone https://github.com/git/git.git
cd git
git checkout v2.0.1
autoconf
./configure
# so far so good...
make

# oops
# ....

SUBDIR perl
make[2]: /home/cplotnicki/dev/git/perl/0: Command not found
perl.mak:375: recipe for target 'blib/lib/.exists' failed
make[2]: *** [blib/lib/.exists] Error 127
Makefile:16: recipe for target 'all' failed
make[1]: *** [all] Error 2
Makefile:1653: recipe for target 'all' failed
make: *** [all] Error 2
```

Want perl as '0' ? Well, why not. Here you are:

```
# link perl as 0 to some directory that is in your path
ln -s /usr/bin/perl ~/tools/0
# also link here, obviously.
# 'perl' is a direct subdir for your git checkout
ln -s /usr/bin/perl perl/0

make # should now compile

# cygwin's permission scheme is very peculiar
# here, have a dirty hack for your default install
# where there is no su or sudo
chmod a+rwX -R /usr/local/share/man/man3
chmod a+rwX -R /usr/local/lib/perl5/site_perl

make install
git --version
# should display 2.0.1.
# update man pages' cache manually
/etc/postinstall/man-db.sh
```

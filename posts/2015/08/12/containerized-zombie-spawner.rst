Recently I was playing with a fully Dockerized setup of Jenkins at work
and found a curious issue there. Whenever Jenkins was polling the git
server the side effect was that it created a zombie ssh process. The
issue is actually
`remediated <https://github.com/jenkinsci/docker/issues/54>`__ by the
Jenkins team now by `explicitly
using <https://github.com/jenkinsci/docker/commit/d5aea67dcae9d62fe4ca6ad961ffe66f65d9a591>`__
a tiny init system called ...
`tini, <https://github.com/krallin/tini>`__ started as the main
container's process instead of just starting Jenkins there. This tiny
tini thing can properly adopt and reap the children. I was all like -
wow, what a great blog entry is coming at me. I was planning to describe
how zombies come to existence on Linux and why Docker should, in my
opinion, provide an adopter-reaper by default and other very interesting
things ! But then I found a really excellent article by the
`Phusion <http://www.phusion.nl/>`__ team
`here <https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/>`__
explaining all that and more. It is very good. You should read it. That
is it. The end. Happy reaping !

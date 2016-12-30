.. title: Using ad hoc Docker volumes on SELinux systems
.. slug: ad-hoc-docker-volumes-selinux
.. date: 2016-12-30 18:28:50 UTC
.. tags: docker, volume, permissions, selinux, container, data
.. category: containers
.. link: 
.. description: 
.. type: text

I've recently tried running some quick Docker commands using host's directory as a volume:

.. code-block:: console

    docker run -i -t -v `pwd`:/mnt debian:jessie bash -c "ls -hal /mnt"
    ls: cannot open directory /mnt: Permission denied

I use Fedora as my main OS, which, it turns out, has some pretty nice SELinux settings. These deny access from inside the container to the outside.
Said Fedora consists mostly of almost-newest-but-stable everything though, which makes Docker to be in a fairly recent version.
A version that understands how to change a SELinux context for the directory we're mounting, by itself ! 
You need at least Docker v1.7 for this.

.. code-block:: console

     docker run -i -t -v `pwd`:/mnt:Z debian:jessie bash -c "ls -hal /mnt"
     total 8.0K
     drwxrwxr-x.  2 1000 1000 4.0K Dec 30 18:34 .
     drwxr-xr-x. 21 root root  242 Dec 30 19:07 ..

Please notice the capital `Z` as a mount parameter.  
And that is it. Mostly. Some cleanup remains, as docker leaves the host's directory with a changed SELinux context.
To restore it you need to 

.. code-block:: console

    restorecon -R `pwd`

Or use any other path you'd like instead of `\`pwd\`` in the examples above.  
Happy dockerizing !


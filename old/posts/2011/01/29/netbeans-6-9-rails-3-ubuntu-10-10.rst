I am a lazy person. I do like things to just work, run out of the box,
name it. I like Ubuntu for it's packaging system and ease of
installation of various software. However using Netbeans from the
default repo could cause you a headache when developing Rails 3 apps.
These just won't run. Let us start with installing the newest version of
the IDE 

.. code-block:: console

    sudo apt-get install netbeans 
    #then go to the Tools->Plugins->Available and install all regarding Ruby

Now go ahead and try running some Rails app. 

.. code-block:: 

    /var/lib/gems/1.9.1/gems/activesupport-3.0.3/lib/active_support/dependencies.rb:239:in `require': /var/lib/gems/1.9.1/gems/activesupport-3.0.3/lib/active_support/cache/mem_cache_store.rb:32: invalid multibyte escape: /[x00-x20%x7F-xFF]/ (SyntaxError)

you say ? Here's a quick fix 

.. code-block:: 

    #edit /usr/share/netbeans/6.9/etc/netbeans.conf
    #=> append -J-Druby.no.kcode=true to the the netbeans_default_options and volia
    # the whole line im my case goes like that:
    netbeans_default_options="-J-client -J-Xss2m -J-Xms32m -J-XX:PermSize=32m -J-XX:MaxPermSize=200m -J-Dapple.laf.useScreenMenuBar=true -J-Dsun.java2d.noddraw=true -J-Dsun.java2d.pmoffscreen=false -J-Druby.no.kcode=true"

Long term solution ? Wait for Netbeans 7.0 as the devs promised it to be fixed there

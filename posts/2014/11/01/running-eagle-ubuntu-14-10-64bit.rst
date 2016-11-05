Eagle is still the first choice when it comes to Open Hardware
electronics design. That's a bit unfortunate because the software itself
is proprietary. Sometimes you need to run it though. For example to
migrate projects over to non-proprietary software ! Say, you'd like to
run new Eagle 7.1 under Ubuntu ? Try repos. Repos have the old major
version 6 only. The harder to get proprietary software the better, I
suppose. Download the blob then: 


.. code-block:: console

    $ wget -c http://web.cadsoft.de/ftp/eagle/program/7.1/eagle-lin-7.1.0.run
    $ chmod a+x eagle-lin-7.1.0.run

Inspect and run the stuff: 


.. code-block:: console

    $ vim eagle-lin-7.1.0.run 
    $ ./eagle-lin-7.1.0.run 
    Ensure the following 32 bit libraries are available:
        libXrender.so.1 =&gt; not found
        libXrandr.so.2 =&gt; not found
        libXcursor.so.1 =&gt; not found
        libfreetype.so.6 =&gt; not found
        libfontconfig.so.1 =&gt; not found
        libXi.so.6 =&gt; not found
        libssl.so.1.0.0 =&gt; not found
        libcrypto.so.1.0.0 =&gt; not found

32bit craziness, you say.
New Ubuntu does not have ia32 libs prepackaged, you say ? Here, have
this handy list of all of the dependencies then: 

.. code-block:: console

    $ sudo apt-get install libxrandr2:i386 libxrender1:i386 libxcursor1:i386 libfreetype6:i386 libfontconfig:i386 libxi6:i386 libssl1.0.0:i386 libcrypto++9:i386
    # should show you the installation wizard [sic !]
    $ ./eagle-lin-7.1.0.run 

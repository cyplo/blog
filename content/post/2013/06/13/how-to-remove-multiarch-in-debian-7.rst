Just a quick one, for me to remember and for you to enjoy. 

.. code-block:: console

    dpkg -l | grep :i386 | cut -s -d ' ' -f3 | xargs apt-get remove -y
    dpkg --remove-architecture i386
    apt-get update

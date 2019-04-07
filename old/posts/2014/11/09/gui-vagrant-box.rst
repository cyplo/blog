Recently I've started working on changing my default development
workflow. I'm evaluating vagrant as a main env manager, and then docker
for extra speed. In short, my ``vagrant up`` boots up new dev box and
then couple of docker containers. What I've found is that there is not
really a plethora of GUI-enabled vagrant boxes, so I've created one ! If
you want to use it, go: 

.. code-block:: console

    vagrant init
    cyplo/ubuntu-gnome-utopic-gui vagrant up 

I will write about the whole setup later, as I'm not yet sure what approach is best for me.

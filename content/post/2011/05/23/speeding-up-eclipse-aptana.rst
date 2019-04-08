As some of you know Aptana is Eclipse. And Eclipse is a Java-based IDE
which means it's not particularly a speedy one. However if you have a
decent amount of ram, like 4gb, it's fairly easy to speed the Eclipse
up. Go ahead and find **eclipse.ini** or **aptana.ini** or other file which
contents look similar. These settings are from my Linux box, I know that
MacOS might be kinda scared by so high values, try lowering the Xmx
and/or others in such a case. 

.. code-block:: 

    --launcher.XXMaxPermSize
    512m
    --launcher.defaultAction
    openFile
    -vmargs
    -Xms128m
    -Xmx2048m

These settings are for the 4gb ram box, try to find the ones which suit you best. MaxPermSize
stands for the maximum amount of the memory to be used by the Java
internals, Xms gives the amount of heap allocated on the VM start and
Xmx is the heap size limit. Start with upping Xms value as it's often
too small which causes the Java VM to make lots of heap resizes on the
app start.

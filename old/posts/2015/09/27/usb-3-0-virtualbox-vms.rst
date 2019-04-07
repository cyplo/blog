Just a quick note on how to get USB 3.0 in Virtualbox for VMs that were
created with USB 1.1 support only. First, download VirtualBox Extension
Pack from `here <https://www.virtualbox.org/wiki/Downloads>`__. Install
it. Then quit Virtualbox completely. Go to your directory that contains
your virtual machine and edit **.vbox** file. Replace the whole
**<USBController>** section with the following: 

.. code-block:: xml

    <USB>
        <Controllers>
            <Controller name="xHCI" type="XHCI"/>
        </Controllers>
        <DeviceFilters/>
    </USB> 

That's it, let me know if it works for you !

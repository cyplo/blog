Hello ! Today we'll talk about driving CNC machines, toolpaths and
Debian, so stay tuned ! I have a separate old PC for driving the CNC
machine via parallel port. This is, as they say, the Only Proper Way and
It Was Always Like That. I'm thinking about changing this to
usb+\ `grbl <https://github.com/grbl/grbl>`__ in the future then ;) Up
till now, my workflow went as follows; 


* Do the research and drawing/parts modeling in FreeCad, on my main workstation
* Export to e.g. DXF
* Import in HeeksCad
* Design machining operations, export gcode
* Copy gcode to a network drive
* Switch the monitor and keyboard to the one of the old PC
* Open gcode in LinuxCNC and go

What happens if it's not perfect at first try though ?! Most commonly the issue  is with the
toolpath, like I want to change feeds or speeds or depth of cut, rarely
it is with the part itself, fortunately. It may have something to do
with the fact that I'm mostly working with other people's parts for now
;) Anyway, to do any correction I need to switch back to the main
workstation, correct in Heeks, re-export to the network drive and switch
back, reimport. Not very annoying but not very convenient either. But
wait. What if...I install Heeks on the old PC ?! It's running
`LinuxCNC <http://linuxcnc.org/>`__ realtime distro, which is based on
Debian wheezy. Heeks packages are available prepackaged for Ubuntu only.
With the help of the
`documentation <https://code.google.com/p/heekscad/wiki/BuildDebianPackages>`__
and the comments there and in other corners of the internet I was able
to get this little script done: 

.. code-block:: bash

    #!/bin/bash
    set -e
    set -v

    sudo apt-get update
    sudo apt-get -y install liboce-visualization-dev libwxgtk2.8-dev libgtkglext1-dev python-dev build-essential bzr git libboost-dev libboost-python-dev subversion debhelper cmake liboce-ocaf2 liboce-ocaf-dev oce-draw
    mkdir heeks_build
    cd heeks_build
    svn checkout http://libarea.googlecode.com/svn/trunk/ libarea
    cd libarea
    dpkg-buildpackage -b -us -uc
    cd ..
    sudo dpkg -i libarea*.deb python-area*.deb
    svn checkout http://heekscad.googlecode.com/svn/trunk/ heekscad
    cd heekscad
    dpkg-buildpackage -b -us -uc
    cd ..
    sudo dpkg -i *heeks*.deb
    svn checkout http://heekscnc.googlecode.com/svn/trunk/ heekscnc
    cd heekscnc
    dpkg-buildpackage -b -us -uc
    cd ..
    git clone https://github.com/aewallin/opencamlib.git
    cd opencamlib
    bzr branch lp:~neomilium/opencamlib/packaging debian
    dpkg-buildpackage -b -us -uc
    cd ..
    sudo dpkg -i python-ocl*.deb
    sudo dpkg -i heekscnc*.deb

Run this on your LinuxCNC machine and that's it. It will download and
build all the dependencies and Heeks CAD and CAM packages. This way, my
current workflow goes more like this: 

* Do the research and drawing/parts modeling in FreeCad, on my main workstation
* Export to e.g. DXF to a network drive
* Switch the monitor and keyboard to the one of the old PC
* Import in HeeksCad
* Design machining operations, export gcode
* Open gcode in LinuxCNC and go
* Repeat last 2 steps if necessary - no machine switching

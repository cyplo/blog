TL;DR - go to `data.cyplo.net <http://data.cyplo.net/dashboard/db/sunpowered>`__ 

Some, rather long, time ago I've `added a custom
python-driven <https://blog.cyplo.net/2014/04/21/adding-voltage-current-measurements-sunpowered-pi/>`__
data acquisition and graphing to my sunpowered RaspberryPi installation
on the balcony. Since then I've upgraded it to Raspi2 and ported the
data thingy to influxdb + grafana. All 3 of those things I am very
positively surprised by. 

RaspberryPi2 - definitely worth the upgrade - it's a speed daemon now.  Small caveat - I recommend
installing raspbian from scratch, especially if you had some custom
overclocking config, as these do not seem to be compatible between 1 and
2. Also RasPi2 needs a microsd card instead of full-sized one. As for
the software - since everything went suprisingly smoothly this post is
not much of a tutorial. Just go to `influxdb <http://influxdb.com/>`__
and `Grafana <http://grafana.org/>`__ and go through the respective
installation documentation. You need x86 64bit server to host this, so
unfortunately no self-hosting on RaspberryPi - at least I wasn't able to
compile the software there. I've `changed the original python scripts
slightly <https://github.com/cyplo/sunpowered/tree/master/software>`__,
to upload the data to influxdb instead of graphing directly via
matplotlib. Then configured grafana to display some cool graphs and that
was pretty much it - you can see the result at
`data.cyplo.net <http://data.cyplo.net/dashboard/db/sunpowered>`__.

Right now I'm testing 2 different sizes of solar panels and
batteries, hooked at the same time. The ADC is connected as it was
before though, so a TODO is to add more measurements, to see how the
individual  panels' output change during the data and how does it affect
each of the batteries.

|IMG_1289| |IMG_1291|

.. |IMG_1289| image:: /wp-content/uploads/2015/05/IMG_1289-e1430570843289-225x300.jpg
   :class: alignleft wp-image-1952 size-medium
   :width: 225px
   :height: 300px
   :target: /wp-content/uploads/2015/05/IMG_1289-e1430570843289.jpg

.. |IMG_1291| image:: /wp-content/uploads/2015/05/IMG_1291-300x225.jpg
   :class: alignleft size-medium wp-image-1955
   :width: 300px
   :height: 225px
   :target: /wp-content/uploads/2015/05/IMG_1291.jpg

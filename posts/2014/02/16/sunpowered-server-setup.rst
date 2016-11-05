Remember my `NAS <https://blog.cyplo.net/2013/03/31/building-nas/>`__
`stuff <https://blog.cyplo.net/2013/05/26/building-nas-software/>`__ ? It
turned out great ! Very reliable storage, I had a disk failure once and
haven't noticed for some time because all the files were just there.
Hardware enhanced virtualization is another great stuff. I ended up
migrating  all my of infrastructure there, each service in separate
virtual machine; email, calendar, contacts, tor node and such. Only
caveat ? Power consumption. This setup just eats Watts. About 50W
constant power usage is not something you want to have turned on
24h/day. One such day I had a realization that this giant ball of plasma
that is hanging out there might be of some use. One side of my balcony
is to the south somewhat, gets lots of sunshine no matter whether it's
morning or evening. Why not exploit that ? That's how my first
solarpowered server setup was born. Enjoy the photos ! Also please find
upgrade options and general notes after the break ! There's a `part
2 <https://blog.cyplo.net/2014/04/21/adding-voltage-current-measurements-sunpowered-pi/>`__\ of
this post you might be interested in as well. 

Setup itself consists of:

-  144W solar panel
-  33Ah 12V battery
-  trusty old WRT54GL
-  Raspberry Pi model B
-  charging controller
-  12V and 5V step up/step down converters. Don't use linear converters,
   especially for the 5V rail. As these will give you the 5V by
   dissipating the difference from 12V directly onto their heatsinks,
   huge power loses.
-  around one hundred M3 hexhead screws with nuts and washers. yup.

The router acts as wireless bridge to my home WiFi network, there are no
cables running from inside the house to the balcony. Router and raspi
use about 8W total. It is winter in here now and  this seems to be
holding nicely, panel being able to charge the battery for the night
during relatively short day, even if the weather is bad. However, I want
more computing power there and this setup does not seem to be very
scalable. Another raspi model B means another 4W constant power usage. I
estimate the whole thing will start loosing power during the night with
about 15W constant consumption. Which is okay for stuff like email
server, but not really for blog or other sites. Hence my first idea for
improvement: discard router and change for the separate raspis, model A,
with wireless network cards each. Should be much better. Some general
notes:

-  Use equipment specifically designed for DC. You want to disconnect
   the solar panel or battery sometimes. To be able to to that without
   that fancy sparks show you need proper DC switch able to handle high
   currents. AC switches as any other equipment dragged from AC land are
   not really a choice. If you use AC mains switch to switch high
   current DC you might end up with nice weld in place of your switch.
   Same for fuses.
-  My ability to cut acrylic to line is nonexistent. Probably maybe use
   better tools ? Or even, since I now know how the box should be cut -
   just order pieces for box 2.0 cut to size already.
-  Same for my ability to make stuff look nice and clean
-  I like the look of bare PCBs inside of transparent box though
-  The box itself seems to be holding up nicely against below zero
   temperatures as well as rain.
-  Air flow is nice, nothing is heating up. Air enters from the bottom,
   heats up a bit and moves up. Goes through the holes on the left, into
   the funnel and exist on the right. Water does not enter as there is
   pretty steep slope there.
-  Watch for SD card corruption. Most often, the cause is having 5V not
   really being 5V. Raspi does not really like lower voltages. One
   preventive measure would be not to use some cheap voltage converters.
   Another is to mount SD card with very conservative options. I use

``/dev/mmcblk0p2 / ext4 defaults,rw,data=journal,journal_checksum,discard  0 1``

-  Make sure your electronic components are rated for -40C to +80C
-  I'm a bit worried of battery being in such proximity to the airco
   unit. We'll see in the summer whether it needs relocation, for now
   the unit is completely powered off.
-  mountain climbing equipment comes in handy when hanging stuff from
   your balcony

Future improvements:

-  most pressing: get the power usage down by changing to model A + wifi
   card
-  add monitoring, something like ADC connected to raspi's GPIO ports,
   gathering voltages all across. I would like to get readings on: solar
   panel voltage, battery voltage, 5V rail actual voltage and the whole
   system power usage at least
-  more safety fuses and bypass diodes

|image0| |image1| |image2| |image3| |image4| |image5| |image6| |image7|
|image8| |image9| |image10| |image11| |image12| |image13| |image14|
|image15| |image16| |image17| |image18| |image19| |image20|

.. |image0| image:: /wp-content/uploads/2014/02/IMG_0912-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0912.jpg
.. |image1| image:: /wp-content/uploads/2014/02/IMG_0913-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0913.jpg
.. |image2| image:: /wp-content/uploads/2014/02/IMG_0915-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0915.jpg
.. |image3| image:: /wp-content/uploads/2014/02/IMG_0916-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0916.jpg
.. |image4| image:: /wp-content/uploads/2014/02/IMG_0917-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0917.jpg
.. |image5| image:: /wp-content/uploads/2014/02/IMG_0918-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0918.jpg
.. |image6| image:: /wp-content/uploads/2014/02/IMG_0921-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0921.jpg
.. |image7| image:: /wp-content/uploads/2014/02/IMG_0922-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0922.jpg
.. |image8| image:: /wp-content/uploads/2014/02/IMG_0923-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0923.jpg
.. |image9| image:: /wp-content/uploads/2014/02/IMG_0925-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0925.jpg
.. |image10| image:: /wp-content/uploads/2014/02/IMG_0927-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0927.jpg
.. |image11| image:: /wp-content/uploads/2014/02/IMG_0930-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0930.jpg
.. |image12| image:: /wp-content/uploads/2014/02/IMG_0932-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0932.jpg
.. |image13| image:: /wp-content/uploads/2014/02/IMG_0933-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0933.jpg
.. |image14| image:: /wp-content/uploads/2014/02/IMG_0934-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0934.jpg
.. |image15| image:: /wp-content/uploads/2014/02/IMG_0935-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0935.jpg
.. |image16| image:: /wp-content/uploads/2014/02/IMG_0937-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0937.jpg
.. |image17| image:: /wp-content/uploads/2014/02/IMG_0940-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0940.jpg
.. |image18| image:: /wp-content/uploads/2014/02/IMG_0941-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0941.jpg
.. |image19| image:: /wp-content/uploads/2014/02/IMG_0942-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_0942.jpg
.. |image20| image:: /wp-content/uploads/2014/02/IMG_09381-150x150.jpg
   :target: /wp-content/uploads/2014/02/IMG_09381.jpg

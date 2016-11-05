Ever cried over damaged disk holding your bitcoin wallet ? Ever
formatted storage holding a perfectly valid and the only copy of your
wallet.dat ? Yes, me too. Well, there's
`Photorec <http://www.cgsecurity.org/wiki/PhotoRec>`__, opensource file
recovery software. It just skips the partition and filesystem info and
scans for plain file signatures on the disk. Unfortunately it does not
recognize Bitcoin's Wallet as a file format. Bitcoin wiki
`states <https://en.bitcoin.it/wiki/Wallet>`__ that wallet.dat is just a
good old BerkeleyDB. Just let me check that with the famous file
command: 

.. code-block:: console

    [cyryl@uglybook ~]$ file .bitcoin/wallet.dat 
    .bitcoin/wallet.dat: Berkeley DB (Btree, version 9, native byte-order)

That is right. Photorec however, has its own file-type
detection magic, for the reason unknown to me. Let's see whether it
works on the wallet. 

.. code-block:: console

    [cyryl@uglybook ~]$ fidentify .bitcoin/wallet.dat 
    .bitcoin/wallet.dat: unknown

Uhoh. Do not abandon hope for not all is lost ! Photorec `provides a
way <http://www.cgsecurity.org/wiki/Add_your_own_extension_to_PhotoRec>`__
for you to add custom signatures. The only missing ingredient appears to
be the knowledge of **file**. Just check your linux installation for
**file**'s detection signatures. On my system these are to be found
under **/usr/share/misc/magic** We need file extensions, offset and some
magic number for Photorec to work. Well, extension is **.dat**, magics
and offsets are stored in the file mentioned above. Translate offsets
from decimal-based to hexs and take care of endianess *et volia* 

.. code-block:: console

    [cyryl@uglybook ~]# cat .photorec.sig 
    dat 0x0 0x00061561
    dat 0x0 0x61150600
    dat 0x0 0x00053162
    dat 0x0 0x62310500
    dat 0xc 0x00061561
    dat 0xc 0x61150600
    dat 0xc 0x00053162
    dat 0xc 0x62310500
    dat 0xc 0x00042253
    dat 0xc 0x53220400
    dat 0xc 0x00040988
    dat 0xc 0x88090400

That is it. Happy wallet recovery.

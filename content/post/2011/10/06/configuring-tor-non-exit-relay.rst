I'm for privacy. I'm for cryptography. I do provide
`Tor <https://www.torproject.org/>`__ relays for the good of all people.
Here's how to configure a classic non-exit Tor relay on your machine. In
my case I got it running on the VPS server, with 2 IP addresses and some
bandwidth quota applied. I wanted the Tor traffic to be easily
recognizable from outside as different from the 'normal' traffic coming
from my server. Second requirement was to make Tor not use my whole
traffic quota up. Here's my config, with some notes 

.. code-block:: 

    cyryl@serv:~$ cat /etc/tor/torrc
    SocksPort 0 # what port to open for local application connections
    SocksListenAddress 127.0.0.1 # accept connections only from localhost
    RunAsDaemon 1

    DataDirectory /var/lib/tor

    ORPort 9001 #switches Tor to server mode
    ORListenAddress tor.cyplo.net
    OutboundBindAddress 91.213.195.28 #what IP address use to direct the outbound traffic
    Nickname cyplonet
    Address tor.cyplo.net
    ExitPolicy reject *:* # no exits allowed
    AccountingStart day 09:00
    AccountingMax 2 GB

    MyFamily cyplonethome, cyplonet


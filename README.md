# Go client for NUT UPS library

https://github.com/lzap/gonutclient

Simple client for connecting to UPS NUT daemon and reading arbitrary variables.
For more info about the TCP text-based protocol visit:

https://networkupstools.org/docs/developer-guide.chunked/ar01s09.html

Features implemented:

* plain username and password authentication
* read a variable

Iŧ's not much but this gets the job done for me.

## Configuration

Well, you need to have a NUT daemon running in order to connect to it on TCP
port 3493. In this example, the username is "monuser" and password is "pass":

    # grep '^MONITOR' /etc/ups/upsmon.conf
    MONITOR eaton3s@localhost 1 monuser pass master

    # grep -v '^#' /etc/ups/upsd.users | egrep -v '^$'
    [monuser]
    password=pass
    upsmon master

For more info how to configure NUT server in Fedora read:
https://lukas.zapletalovi.com/2019/06/configuring-eaton-3s-ups-with-fedora-30.html

To read values from the UPS, use the provided CLI tool:

    # upsc eaton3s

Or use telnet instead:

    # telnet localhost 3493
    USERNAME monuser
    OK
    PASSWORD passFORshutdownBLAH
    OK
    LOGIN eaton3s
    OK
    GET VAR eaton3s ups.load
    VAR eaton3s ups.load "30"
    LOGOUT
    OK Goodbye

## Development

There is a simple stub server written in Ruby for development on system without
UPS or NUT server. If you implement a feature, make sure the stub is up to
date.

Then file a PR.

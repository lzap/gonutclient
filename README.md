# Go client for NUT UPS library

https://github.com/lzap/gonut-client

Simple client for connecting to UPS NUT daemon and reading arbitrary variables.
For more info about the TCP text-based protocol visit:

https://networkupstools.org/docs/developer-guide.chunked/ar01s09.html

Features implemented:

* plain username and password authentication
* read a variable

Iŧ's not much but this gets the job done for me.

## Development

There is a simple stub server written in Ruby for development on system without
UPS or NUT server. If you implement a feature, make sure the stub is up to
date.

Then file a PR.

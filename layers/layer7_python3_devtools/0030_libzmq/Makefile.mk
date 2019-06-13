include ../../../adm/root.mk
include ../../package.mk

export NAME=zeromq
export VERSION=4.3.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=64cbf3577afdbfda30358bc757a6ac83
DESCRIPTION=\
The ZeroMQ lightweight messaging kernel is a library which extends the standard socket interfaces with features traditionally provided by specialised messaging middleware products.\
ZeroMQ sockets provide an abstraction of asynchronous message queues, multiple messaging patterns, message filtering (subscriptions), seamless access to multiple transport protocols and more.
WEBSITE=zeromq.org
LICENSE=LGPL v3

all:: $(PREFIX)/lib/libzmq.so
$(PREFIX)/lib/libzmq.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install

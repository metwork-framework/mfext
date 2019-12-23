include ../../../adm/root.mk
include ../../package.mk

export NAME=ack
export VERSION=2.16-single-file
export EXTENSION=
export CHECKTYPE=MD5
export CHECKSUM=7085b5a5c76fda43ff049410870c8535
DESCRIPTION=\
ACK is a tool like grep, optimized for programmers
WEBSITE=https://beyondgrep.com/
LICENSE=Artistic

#Installing ack 3.2.0 would need to install perl module Getopt-Long >= 2.39
#(see https://github.com/beyondgrep/ack3/issues/193) which is not available as
#an rpm on CentOS6. We may install it by doing :
# yum install perl-CPAN
# cpan App::cpanminus (to install cpanm)
# cpanm https://cpan.metacpan.org/authors/id/J/JV/JV/Getopt-Long-2.39.tar.gz
#   (or wget + cpanm ./GetOpt-Long-2.39.tar.gz)
#Is it worthwhile for our usage of ack ?

all:: $(PREFIX)/bin/ack
$(PREFIX)/bin/ack:
	$(MAKE) --file=../../Makefile.standard download
	cd build && cp -f $(NAME)-$(VERSION) $(PREFIX)/bin/ack
	chmod a+rx $(PREFIX)/bin/ack

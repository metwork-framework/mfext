include ../../../adm/root.mk
include ../../package.mk

export NAME=demeter-python
export VERSION=1.0.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=27d96038b6f578c272fbbb6679d40a56
DESCRIPTION=\
	Demeter : DEcodeur METEo Rapide (en particulier pour le bufr)
WEBSITE=http://www.meteo.fr
LICENSE=meteo france
SHORT_VERSION=1.0.0


all:: $(PREFIX)/lib/libcodes.so
$(PREFIX)/lib/libcodes.so:
	layer_wrapper --layers=python3_scientific@mfext -- $(MAKE) --file=../../Makefile.standard \
	download uncompress configure build install python3pyinstall

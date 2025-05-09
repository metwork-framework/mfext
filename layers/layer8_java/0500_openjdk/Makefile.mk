include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

#We will have to upgrade to 12.0.2 someday
export NAME=openjdk
export VERSION=21.0.7+6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=722d2bab6c5740cda1e61b8ef609cb7d
export ARCHIVE=OpenJDK21U-jdk_x64_linux_hotspot_21.0.7_6.tar.gz
DESCRIPTION=\
The Adoptium Working Group promotes and supports high-quality runtimes and associated technology for use across the Java ecosystem
WEBSITE=https://adoptium.net/fr/
LICENSE=Apache 2.0

all:: $(PREFIX)/bin/java
$(PREFIX)/bin/java:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/jdk-$(VERSION) && for DIR in bin conf include jmods legal lib man release; do rm -Rf $(PREFIX)/$${DIR}; cp -Rf $${DIR} $(PREFIX)/; done

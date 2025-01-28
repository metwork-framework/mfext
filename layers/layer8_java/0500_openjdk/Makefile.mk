include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

#We will have to upgrade to 12.0.2 someday
export NAME=openjdk
export VERSION=17+20
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ce5c445995da047046fecbcb4463ae51
export ARCHIVE=OpenJDK-jdk_x64_linux_hotspot_2021-05-06-23-30.tar.gz
DESCRIPTION=\
AdoptOpenJDK uses infrastructure, build and test scripts to produce prebuilt binaries from OpenJDK™ class libraries and a choice of either the OpenJDK HotSpot or Eclipse OpenJ9 VM.\
All AdoptOpenJDK binaries and scripts are open source licensed and available for free.
WEBSITE=https://adoptopenjdk.net
LICENSE=GPL v2 with Classpath Exception (GPLv2+CE).

all:: $(PREFIX)/bin/java
$(PREFIX)/bin/java:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/jdk-$(VERSION) && for DIR in bin conf include jmods legal lib man release; do rm -Rf $(PREFIX)/$${DIR}; cp -Rf $${DIR} $(PREFIX)/; done

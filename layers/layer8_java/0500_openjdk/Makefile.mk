include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

#We will have to upgrade to 12.0.2 someday
export NAME=openjdk
export VERSION=11.0.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=06b885585bce44c3151719b0e242f855
export ARCHIVE=$(NAME)-$(VERSION)_linux-x64_bin.tar.gz
DESCRIPTION=\
OpenJDK (Open Java Development Kit) is a free and open-source implementation of the Java Platform, Standard Edition (Java SE).
WEBSITE=https://jdk.java.net
LICENSE=specific

all:: $(PREFIX)/bin/java
$(PREFIX)/bin/java:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/jdk-$(VERSION) && for DIR in bin conf include jmods legal lib release; do rm -Rf $(PREFIX)/$${DIR}; cp -Rf $${DIR} $(PREFIX)/; done

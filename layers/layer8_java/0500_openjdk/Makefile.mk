include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=openjdk
export VERSION=11.0.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6c2c81fdc2c30655df6350c337f6bb8b
export ARCHIVE=$(NAME)-$(VERSION)_linux-x64_bin.tar.gz
DESCRIPTION=\
OpenJDK (Open Java Development Kit) is a free and open-source implementation of the Java Platform, Standard Edition (Java SE).
WEBSITE=https://jdk.java.net
LICENSE=specific

all:: $(PREFIX)/bin/java
$(PREFIX)/bin/java:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/jdk-$(VERSION) && for DIR in bin conf include jmods legal lib release; do rm -Rf $(PREFIX)/$${DIR}; cp -Rf $${DIR} $(PREFIX)/; done

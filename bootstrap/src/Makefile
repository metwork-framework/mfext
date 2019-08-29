all:
	cd pcre && $(MAKE)
	cd glib2 && $(MAKE)
	cd dtreetrawl && $(MAKE)
	cd mfutil_c && $(MAKE)
	cd layerapi2 && $(MAKE)
	cd envtpl && $(MAKE)
	cd .. && rm -f bin/glib* bin/gio* bin/gapplication bin/gdbus* bin/gio-querymodules bin/gobject-query bin/gresource bin/gsettings bin/gtester* bin/pcre-config bin/pcre*
	cd .. && rm -Rf include
	cd .. && rm -Rf lib/gio lib/glib-2.0 lib/pkgconfig lib/libgio-* lib/libgmodule-* lib/libgobject-* lib/libgthread-* lib/libpcrecpp.* lib/libpcreposix.*

clean:
	cd pcre && $(MAKE) clean
	cd glib2 && $(MAKE) clean
	cd dtreetrawl && $(MAKE) clean
	cd mfutil_c && $(MAKE) clean
	cd layerapi2 && $(MAKE) clean
	cd envtpl && $(MAKE) clean

mrproper: clean
	rm -Rf ../bin
	rm -Rf ../opt
	rm -Rf ../lib
	rm -Rf ../include
	rm -Rf ../share

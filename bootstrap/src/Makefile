all:
	cd dtreetrawl && $(MAKE)
	cd mfutil_c && $(MAKE)
	cd layerapi2 && $(MAKE)
	cd envtpl && $(MAKE)

clean:
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

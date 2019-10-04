$(PREFIX)/bin/$(MFMODULE_LOWERCASE).status: $(MFEXT_HOME)/share/templates/mfxxx.status $(wildcard mfxxx.status.custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh mfxxx.status .custom >$@
	chmod +x $@

$(PREFIX)/bin/$(MFMODULE_LOWERCASE).start: $(MFEXT_HOME)/share/templates/mfxxx.start $(wildcard mfxxx.start.custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh mfxxx.start .custom >$@
	chmod +x $@

$(PREFIX)/bin/$(MFMODULE_LOWERCASE).autorestart: $(MFEXT_HOME)/share/templates/mfxxx.autorestart $(wildcard mfxxx.autorestart.custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh mfxxx.autorestart .custom >$@
	chmod +x $@

$(PREFIX)/bin/$(MFMODULE_LOWERCASE).stop: $(MFEXT_HOME)/share/templates/mfxxx.stop $(wildcard mfxxx.stop.custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh mfxxx.stop .custom >$@
	chmod +x $@

$(PREFIX)/bin/$(MFMODULE_LOWERCASE).init: $(MFEXT_HOME)/share/templates/mfxxx.init $(wildcard mfxxx.init.custom)
	$(MFEXT_HOME)/bin/_make_file_from_template.sh mfxxx.init .custom >$@
	chmod +x $@

$(PREFIX)/bin/cronwrap.sh: $(MFEXT_HOME)/share/templates/cronwrap.sh
	$(MFEXT_HOME)/bin/_make_file_from_template.sh cronwrap.sh >$@
	chmod +x $@

all:: profiles $(PREFIX)/bin/cronwrap.sh $(PREFIX)/bin/$(MFMODULE_LOWERCASE).status $(PREFIX)/bin/$(MFMODULE_LOWERCASE).start $(PREFIX)/bin/$(MFMODULE_LOWERCASE).stop $(PREFIX)/bin/$(MFMODULE_LOWERCASE).autorestart $(PREFIX)/bin/$(MFMODULE_LOWERCASE).init load_env

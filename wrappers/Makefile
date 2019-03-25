.PHONY: check clean all

BINS=make_custom_wrapper.sh flake8.sh flake82.sh flake83.sh pylint2.sh pylint3.sh nosetests2.sh nosetests3.sh pylint.sh nosetests.sh

include ../adm/root.mk
include $(MFEXT_HOME)/share/subdir_root.mk

all:: $(BINS) $(MFEXT_HOME)/share/templates/custom_wrapper.c $(MFEXT_HOME)/bin/python2 $(MFEXT_HOME)/bin/python3 $(MFEXT_HOME)/bin/python $(MFEXT_HOME)/bin/sphinx_wrapper

$(MFEXT_HOME)/share/templates/custom_wrapper.c: custom_wrapper.c
	mkdir -p $(MFEXT_HOME)/share/templates
	cp -f $< $@

$(MFEXT_HOME)/bin/python2: custom_wrapper.c make_custom_wrapper.sh
	./make_custom_wrapper.sh python2_core@mfext,-python2@mfext,-python2@mfcom,-python2@{MODULE_LOWERCASE} python $@

$(MFEXT_HOME)/bin/python3: custom_wrapper.c make_custom_wrapper.sh
	./make_custom_wrapper.sh python3_core@mfext,-python3@mfext,-python3@mfcom,-python3@{MODULE_LOWERCASE} python $@

$(MFEXT_HOME)/bin/python: custom_wrapper.c make_custom_wrapper.sh
	./make_custom_wrapper.sh python@mfext,-python@mfcom,-python@{MODULE_LOWERCASE} python $@

$(MFEXT_HOME)/bin/sphinx_wrapper: custom_wrapper.c make_custom_wrapper.sh
	./make_custom_wrapper.sh python3_devtools@mfext sphinx-build $@

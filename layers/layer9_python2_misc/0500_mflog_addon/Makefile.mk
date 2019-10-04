include ../../../adm/root.mk
include ../../core_layer.mk

EGG_P2=mflog_metwork_addon-0.0.0-py$(PYTHON2_SHORT_VERSION).egg

clean:: pythonclean

all:: dist/$(EGG_P2)

dist/$(EGG_P2):
	mkdir -p $(MFEXT_HOME)/opt/python$(METWORK_PYTHON_MODE)_misc/lib/python$(PYTHON_SHORT_VERSION)/site-packages
	python setup.py install --prefix=$(MFEXT_HOME)/opt/python2_misc

test:
	@echo "***** PYTHON2 TESTS *****"
	flake8.sh --exclude=build .
	find . -name "*.py" ! -path './build/*' -print0 |xargs -0 layer_wrapper --layers=python2@mfext -- pylint.sh --errors-only

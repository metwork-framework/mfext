include ../../../adm/root.mk
include ../../core_layer.mk

EGG_P3=mflog_metwork_addon-0.0.0-py$(PYTHON3_SHORT_VERSION).egg

clean:: pythonclean

all:: dist/$(EGG_P3)

dist/$(EGG_P3):
	mkdir -p $(MFEXT_HOME)/opt/python$(METWORK_PYTHON_MODE)_misc/lib/python$(PYTHON_SHORT_VERSION)/site-packages
	python setup.py install --prefix=$(MFEXT_HOME)/opt/python3_misc

test:
	@echo "***** PYTHON3 TESTS *****"
	flake8.sh --exclude=build .
	find . -name "*.py" ! -path './build/*' -print0 |xargs -0 layer_wrapper --layers=python3@mfext -- pylint.sh --errors-only

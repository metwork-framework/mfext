include ../../../adm/root.mk
include ../../core_layer.mk

EGG=conf_monitor-0.0.0-py$(PYTHON_SHORT_VERSION).egg

clean:: pythonclean

all:: dist/$(EGG)

dist/$(EGG):
	mkdir -p $(MFEXT_HOME)/opt/python$(METWORK_PYTHON_MODE)_misc/lib/python$(PYTHON_SHORT_VERSION)/site-packages
	python setup.py install --prefix=$(MFEXT_HOME)/opt/python$(METWORK_PYTHON_MODE)_misc

test:
	flake8.sh --exclude=build .
	find . -name "*.py" ! -path './build/*' -print0 |xargs -0 pylint.sh --errors-only

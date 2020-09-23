include ../../../adm/root.mk
include ../../core_layer.mk

EGG=mfutil-0.0.0-py$(PYTHON_SHORT_VERSION).egg

clean:: pythonclean

all:: dist/$(EGG)

dist/$(EGG):
	mkdir -p $(MFEXT_HOME)/opt/python$(METWORK_PYTHON_MODE)_misc/lib/python$(PYTHON_SHORT_VERSION)/site-packages
	python setup.py install --prefix=$(MFEXT_HOME)/opt/python$(METWORK_PYTHON_MODE)_misc

test:
	flake8.sh --exclude=build .
	find . -name "*.py" ! -path './build/*' -print0 |xargs -0 pylint.sh --errors-only
	cd tests && nosetests.sh --nocapture .

coverage:
	cd tests && nosetests.sh --with-coverage --cover-package=mfutil --cover-erase --cover-html --cover-html-dir=coverage --nocapture .

pythonclean:
	rm -rf build dist *.egg-info
	rm -f `find -name "*.pyc"`
	rm -rf `find -name "__pycache__"`
	rm -rf tests/.coverage tests/coverage
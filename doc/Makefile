# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = $(MFEXT_HOME)/opt/devtools/bin/sphinx_wrapper
SPHINXPROJ    = mfext
SOURCEDIR     = .
BUILDDIR      = _build

RST_FILES=$(shell ls *.md |grep -v tempo.md 2>/dev/null |sed 's/\.md$$/\.rst/g')
COMMON_DOCFILES=configure_a_metwork_package.rst README.rst installation_guide.rst
CHANGELOGS_FILES=$(shell ls -r ../CHANGELOG*.md |awk -F '/' '{print $$2;}' |sed 's/\.md$$/\.rst/g')
CHANGELOGS_RST_TMPL=changelogs.tmpl
CHANGELOGS_RST_FILE=changelogs.rst

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

layer_root_custom.rst: layer_root_custom.md
	true

%.rst: %.md
	rm -f tempo.md
	echo ".. GENERATED FILE, DO NOT EDIT (edit $< instead)" >tempo.md
	echo ":original_file: $<" >>tempo.md
	echo >>tempo.md
	cat $< |envtpl --reduce-multi-blank-lines >>tempo.md
	layer_wrapper --layers=python3_devtools@mfext -- m2r --overwrite tempo.md
	cat tempo.rst >$@
	rm -f tempo.md

superclean:
	rm -f tempo.*
	rm -f *.mdtemp
	rm -f /tmp/layer_root_custom.md
	cp -f layer_root_custom.md /tmp 2>/dev/null || true
	rm -f layer_*.md
	cp /tmp/layer_root_custom.md . 2>/dev/null || true
	rm -f layer_*.rst
	rm -f configure_a_metwork_package*
	rm -f installation_guide*
	rm -f CHANGELOG*.{md,rst}
	rm -f changelogs.rst
	rm -f layerapi2.rst
	rm -f layers.md
	rm -f README.{md,rst}

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
html: $(CHANGELOGS_FILES) $(COMMON_DOCFILES) $(IPYNB_FILES) components.md $(RST_FILES) Makefile
	echo $(CHANGELOGS_FILES)
	rm -f tempo.*
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
clean: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	rm -f tempo.*
	rm -f layer_*.rst

README.md: ../.metwork-framework/README.md
	cp -f $< $@

configure_a_metwork_package.md: ../.metwork-framework/configure_a_metwork_package.md
	cp -f $< $@

installation_guide.md: ../.metwork-framework/installation_guide.md
	cp -f $< $@

components.md:
	echo "# Full list of components" >$@
	layer_wrapper --layers=python3_devtools@mfext -- _yaml_to_md.py ALL >>$@

CHANGELOG-%.md: ../CHANGELOG-%.md
	cp -f $< $@
	echo "   $(shell echo "$<" |awk -F '/' '{print $$2;}' |sed 's/\.md$$//g')" >>$(CHANGELOGS_RST_FILE)

CHANGELOG.md: ../CHANGELOG.md
	cp -f $< $@
	cat ${CHANGELOGS_RST_TMPL} >$(CHANGELOGS_RST_FILE)
	echo "   $(shell echo "$<" |awk -F '/' '{print $$2;}' |sed 's/\.md$$//g')" >>$(CHANGELOGS_RST_FILE)

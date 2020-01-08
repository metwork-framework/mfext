CHANGELOGS_SOURCES=$(shell cd .. && ls CHANGELOG-*.md 2>/dev/null)
CHANGELOGS_TARGETS=$(addprefix 900-changelogs/, $(CHANGELOGS_SOURCES))

all: $(CHANGELOGS_TARGETS) 850-components.md

900-changelogs/%: ../%
	cat $< |sed 's/^# \(.*\) CHANGELOG$$/# \1/g' >$@

850-components.md: ../.metwork-framework/components.md
	rm -f $@
	echo "# Available components" >$@
	echo >>$@
	echo "!!! note" >>$@
	echo "    Available components in all mfext layers (excepting add-ons)" >>$@
	echo >>$@
	cat $< >>$@

clean:
	rm -f 900-changelogs/*.md
	rm -f 850-components.md

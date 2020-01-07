CHANGELOGS_SOURCES=$(shell cd .. && ls CHANGELOG-*.md 2>/dev/null)
CHANGELOGS_TARGETS=$(addprefix 900-changelogs/, $(CHANGELOGS_SOURCES))

all: $(CHANGELOGS_TARGETS)

900-changelogs/%: ../%
	cat $< |sed 's/^# \(.*\) CHANGELOG$$/# \1/g' >$@

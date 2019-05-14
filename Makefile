.PHONY: all release debug

all: release

release:
	nim c -f -d:release -o:app --threads:on --nimcache=nimcache src/app.nim

debug:
	nim c -f -o:app --threads:on --nimcache=nimcache src/app.nim

run:
	nim c -r -o:app --threads:on --nimcache=nimcache src/app.nim
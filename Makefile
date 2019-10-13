.PHONY: all release debug

all: release

release:
	nim c -f -d:release -o:app --nimcache=nimcache --threads:on src/app.nim

debug:
	nim c -f -o:app --nimcache=nimcache src/app.nim

run:
	nim c -r -o:app --nimcache=nimcache --threads:on src/app.nim
	
clean:
	rm -rf nimcache app

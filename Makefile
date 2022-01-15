.PHONY: all release debug

all: release

deps:
	nimble install -y jester

release:
	nim c -f -d:release -o:app --nimcache=nimcache --threads:on src/app.nim

debug:
	nim c -f -d:nimDebugDlOpen -o:app --nimcache=nimcache src/app.nim

run:
	nim c -r -o:app --nimcache=nimcache --threads:on src/app.nim
	
clean:
	rm -rf nimcache app

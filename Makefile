.PHONY: all mingw32
all: mingw32

mingw32:
	MINGW_INSTALLS=mingw32 SCONS_OPTS="PATH=$$PATH --config=force --no-cache --debug=findlibs,includes,explain,presub" makepkg-mingw -eLf


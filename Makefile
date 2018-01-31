.PHONY: all mingw32
all: mingw32

mingw32:
	if [ "$$MSYSTEM" \!= "MINGW32" ]; then echo "Careful now --- only tested in the 32-bit shell!" ; fi
	MINGW_INSTALLS=mingw32 SCONS_OPTS="PATH=$$PATH --config=force --no-cache --debug=findlibs,includes,explain,presub" makepkg-mingw -eLf


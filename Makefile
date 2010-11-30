.PHONY: all clean

all:
	OOC_LIBS=/blue/Dev rock -v nonfi.ooc

clean:
	rm -rf .libs/nonfi* nonfi

mrproper:
	rm -rf .libs *_tmp nonfi

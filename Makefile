<<<<<<< HEAD
.PHONY: all clean

all:
	OOC_LIBS=/blue/Dev rock -v nonfi.ooc

clean:
	rm -rf .libs/nonfi* nonfi

mrproper:
	rm -rf .libs *_tmp nonfi
=======
all:
	ooc -v -g -sourcepath=source -driver=sequence -noclean nonfi/nonfi

clean:
	rm -rfv ooc_tmp
>>>>>>> e5e52e4ec583027bb232a141620290b0358427f5

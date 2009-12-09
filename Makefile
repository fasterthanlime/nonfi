all:
	ooc -v -g -sourcepath=source -driver=sequence -noclean nonfi/nonfi

clean:
	rm -rfv ooc_tmp

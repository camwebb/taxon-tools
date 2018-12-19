PREFIX = /usr/local

check: namematch test/listA test/listB
	./namematch -a test/listA -b test/listB -o test/out -f
	bash -c "if [ -z `diff test/out.ok test/out` ] ; then echo '** PASS **'; else echo '** FAIL **' ; fi "
	rm -f test/out

install: namematch share/taxon-tools.awk
	mkdir -p $(PREFIX)/bin
	cp -f namematch $(PREFIX)/bin/.
	mkdir -p $(PREFIX)/share/awk
	cp -f share/taxon-tools.awk $(PREFIX)/share/awk/.

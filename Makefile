PREFIX = /usr/local

check: matchnames test/listA test/listB
	./matchnames -a test/listA -b test/listB -o test/out -f
	bash -c "if [ -z `diff test/out.ok test/out` ] ; then echo '** PASS **'; else echo '** FAIL **' ; fi "
	rm -f test/out

install: matchnames share/taxon-tools.awk
	mkdir -p $(PREFIX)/bin
	cp -f matchnames $(PREFIX)/bin/.
	mkdir -p $(PREFIX)/share/awk
	cp -f share/taxon-tools.awk $(PREFIX)/share/awk/.
	mkdir -p $(PREFIX)/share/man/man1
	cp -f doc/matchnames.1 $(PREFIX)/share/man/man1/.

man: doc/matchnames.md
	pandoc -s -t man -o doc/matchnames.1 doc/matchnames.md

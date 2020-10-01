PREFIX = /usr/local

aregexversion: matchnames
	gawk -l aregex --version | sed '/^Copyright/,$$ d'
	cp matchnames matchnames.ori
	sed -i -E 's/#@> //g' matchnames
	sed -i -E 's/^(.*#@<)/#\1/g' matchnames

check: matchnames parsenames test/listA test/listB test/names test/matchnames.ok test/parsenames.ok
	@./matchnames -a test/listA -b test/listB -o test/out -F
	@bash -c "if [ `diff test/matchnames.ok test/out | wc | gawk '{print $$1}'` -eq 0 ] ; then echo '** matchnames PASS **'; else echo '** matchnames FAIL **' ; fi "
	@rm -f test/out
	@cat test/names | ./parsenames > test/out
	@bash -c "if [ `diff test/parsenames.ok test/out | wc | gawk '{print $$1}'` -eq 0 ] ; then echo '** parsenames PASS **'; else echo '** parsenames FAIL **' ; fi "
	@rm -f test/out

install: matchnames parsenames share/taxon-tools.awk man
	#@gawk -l aregex --version > | sed '/^Copyright/,$$ d'
	mkdir -p $(PREFIX)/bin
	cp -f matchnames parsenames $(PREFIX)/bin/.
	mkdir -p $(PREFIX)/share/awk
	cp -f share/taxon-tools.awk $(PREFIX)/share/awk/.
	mkdir -p $(PREFIX)/share/man/man1
	cp -f doc/matchnames.1 $(PREFIX)/share/man/man1/.
	cp -f doc/parsenames.1 $(PREFIX)/share/man/man1/.

PHONY: man
man: doc/matchnames.1 doc/parsenames.1
%.1: %.md
	pandoc --eol=lf -s -t man -o $@ $<

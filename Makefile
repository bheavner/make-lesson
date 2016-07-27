include config.mk

# Generate summary table.
results.txt : *.dat $(ZIPF_SRC)
	$(ZIPF_EXE) *.dat > $@

#Count words
.PHONY : dat
dats: isles.dat abyss.dat last.dat

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

.PHONY : clean
clean : 
	rm -f *.dat results.txt

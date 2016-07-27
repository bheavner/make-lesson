# Generate summary table.
results.txt : *.dat zipf_test.py
	python zipf_test.py *.dat > $@

#Count words
.PHONY : dat
dats: isles.dat abyss.dat last.dat

isles.dat : books/isles.txt wordcount.py
	python wordcount.py $< $@

abyss.dat : books/abyss.txt wordcount.py
	python wordcount.py $< $@

last.dat : books/last.txt wordcount.py
	python wordcount.py $< $@

.PHONY : clean
clean : 
	rm -f *.dat results.txt

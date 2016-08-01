include config.mk

ARCHIVE_DIR=zipf_analysis
TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst books/%.txt, %.png, $(TXT_FILES))

## archive     : create an archive containing all code, data, plots, and summary table
FILE_LIST=$(TXT_FILES) $(DAT_FILES) $(PNG_FILES) $(COUNT_SRC) $(ZIPF_SRC) $(PLOT_SRC) results.txt Makefile config.mk
.PHONY : archive
archive : results.txt $(PNG_FILES)
	mkdir -p $(ARCHIVE_DIR)
	cp $(FILE_LIST) $(ARCHIVE_DIR)
	tar -czf zipf_analysis.tar.gz $(ARCHIVE_DIR)

## all         : Generate Zipf summary table and plots of word counts.
.PHONY : all
all : results.txt $(PNG_FILES)

## results.txt : Generate Zipf summary table.
results.txt : $(DAT_FILES) $(ZIPF_SRC)
	$(ZIPF_EXE) *.dat > $@

## dats        : Count words in text files.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

## pngs        : Plot word counts.
.PHONY : pngs
pngs : $(PNG_FILES)

%.png : %.dat $(PLOT_SRC)
	@echo $(PLOT_EXE) $*.dat $*.png
	$(PLOT_EXE) $*.dat $*.png

## clean       : Remove auto-generated files.
.PHONY : clean
clean : 
	rm -f $(DAT_FILES) $(PNG_FILES) results.txt
	rm -rf $(ARCHIVE_DIR)

## variables   : Print variables.
.PHONY: variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo PNG_FILES: $(PNG_FILES)

.PHONY: help
help : Makefile
	@sed -n 's/^##//p' $<

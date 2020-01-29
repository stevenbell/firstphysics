# Name of the main lyx file (without the extension) that we want to process
BASENAME = first_encounter_with_physics

# Extensions of temporary files we want to remove
# Only remove $(BASENAME).tex, not all .tex, since the glossary source is .tex!
TOCLEAN = *.aux *.glg *.glo *.gls *.idx *.ilg *.ind *.ist *.log *.out *.pdf *.toc $(BASENAME).tex

all:
	lyx -e pdflatex -f all $(BASENAME)
	pdflatex -draftmode $(BASENAME)
	makeglossaries $(BASENAME)
	makeindex $(BASENAME)
	pdflatex $(BASENAME)

clean:
	rm $(TOCLEAN)


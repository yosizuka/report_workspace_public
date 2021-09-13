source_markdown = source.md
source_tex = source.tex
source_pdf = source.pdf
cover = cover.pdf
cover_exists = $(shell ls src | grep ${cover})
output = output.pdf

all:
	pandoc src/$(source_markdown) -F pandoc-crossref --template=src/templates/template.tex -o src/$(source_tex)
	latexmk -outdir=src src/$(source_tex) 
	if [ "$(cover)" = "$(cover_exists)" ]; then \
		src/merge_pdf src/$(cover) src/$(source_pdf) out/$(output); \
	else \
		src/merge_pdf src/$(source_pdf) out/$(output); \
	fi

clean:
	cd src;rm -f *.aux *.bbl *.bcf *.blg *.dvi *.fdb_latexmk *.fls *.log *.out *.run.xml *.synctex.gz

reset:
	cd src;rm -f *.aux *.bbl *.bcf *.blg *.dvi *.fdb_latexmk *.fls *.log *.out *.run.xml *.synctex.gz $(source_tex) $(source_pdf) ../out/$(output)

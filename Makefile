build: clean
	mkdir -p output/xin-jing
	xelatex -output-directory=output/xin-jing src/xin-jing/main.tex
pdfinfo:
	pdfinfo output/xin-jing/main.pdf

clean:
	rm -rf output
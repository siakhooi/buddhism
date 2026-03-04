build: clean
	mkdir -p output/xin-jing
	cd src/xin-jing && xelatex -interaction=nonstopmode -output-directory=../../output/xin-jing main.tex

pdfinfo:
	pdfinfo output/xin-jing/main.pdf

clean:
	rm -rf output
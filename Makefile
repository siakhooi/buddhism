build: clean
	./scripts/build.sh xin-jing
	./scripts/build_pdf.sh xin-jing

pdfinfo:
	pdfinfo output/xin-jing/main.pdf

clean:
	rm -rf output www/books

release:
	./scripts/create-release.sh

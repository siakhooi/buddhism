info:
all: clean build2 build1
build1:
	./scripts/build.sh xin-jing 2>&1 | tee build-xin-jing.log
	./scripts/build_pdf.sh xin-jing 2>&1 | tee build-xin-jing-pdf.log
build2:
	./scripts/build.sh jin-gang-jing 2>&1 | tee build-jin-gang-jing.log
	./scripts/build_pdf.sh jin-gang-jing 2>&1 | tee build-jin-gang-jing-pdf.log
clean:
	rm -rf output www/books
release:
	./scripts/create-release.sh
pdfinfo1:
	pdfinfo www/books/xin-jing.pdf
pdfinfo2:
	pdfinfo www/books/jin-gang-jing.pdf

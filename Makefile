info:
all: clean build2 build1
build1:
	./scripts/build.sh xin-jing
	./scripts/build_pdf.sh xin-jing
build2:
	./scripts/build.sh jin-gang-jing
	./scripts/build_pdf.sh jin-gang-jing 2>&1 | tee build-jin-gang-jing.log
clean:
	rm -rf output www/books
release:
	./scripts/create-release.sh
pdfinfo:
	pdfinfo output/xin-jing/main.pdf

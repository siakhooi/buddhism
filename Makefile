info:
build1:
	./scripts/build.sh xin-jing 2>&1 | tee build-xin-jing.log
	./scripts/build_pdf.sh xin-jing 2>&1 | tee build-xin-jing-pdf.log
build2:
	./scripts/build.sh jin-gang-jing 2>&1 | tee build-jin-gang-jing.log
	./scripts/build_pdf.sh jin-gang-jing 2>&1 | tee build-jin-gang-jing-pdf.log
build3:
	./scripts/build.sh shi-xiao-zhou 2>&1 | tee build-shi-xiao-zhou.log
	./scripts/build_pdf.sh shi-xiao-zhou 2>&1 | tee build-shi-xiao-zhou-pdf.log
build4:
	./scripts/build.sh yao-shi-jing 2>&1 | tee build-yao-shi-jing.log
	./scripts/build_pdf.sh yao-shi-jing 2>&1 | tee build-yao-shi-jing-pdf.log
build5:
	./scripts/build.sh leng-qie-jing 2>&1 | tee build-leng-qie-jing.log
	./scripts/build_pdf.sh leng-qie-jing 2>&1 | tee build-leng-qie-jing-pdf.log

all: clean
	./scripts/build-all.sh 2>&1 | tee build-all.log
clean:
	rm -rf output www/books
release:
	./scripts/create-release.sh
pdfinfo1:
	pdfinfo www/books/xin-jing.pdf
pdfinfo2:
	pdfinfo www/books/jin-gang-jing.pdf
pdfinfo3:
	pdfinfo www/books/shi-xiao-zhou.pdf
pdfinfo4:
	pdfinfo www/books/yao-shi-jing.pdf
pdfinfo5:
	pdfinfo www/books/leng-qie-jing.pdf


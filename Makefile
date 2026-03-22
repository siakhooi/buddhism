info:
build1:
	./scripts/build.sh xin-jing 2>&1 | tee output/build-xin-jing.log
	./scripts/build_pdf.sh xin-jing 2>&1 | tee output/build-xin-jing-pdf.log
build2:
	./scripts/build.sh jin-gang-jing 2>&1 | tee output/build-jin-gang-jing.log
	./scripts/build_pdf.sh jin-gang-jing 2>&1 | tee output/build-jin-gang-jing-pdf.log
build3:
	./scripts/build.sh shi-xiao-zhou 2>&1 | tee output/build-shi-xiao-zhou.log
	./scripts/build_pdf.sh shi-xiao-zhou 2>&1 | tee output/build-shi-xiao-zhou-pdf.log
build4:
	./scripts/build.sh yao-shi-jing 2>&1 | tee output/build-yao-shi-jing.log
	./scripts/build_pdf.sh yao-shi-jing 2>&1 | tee output/build-yao-shi-jing-pdf.log
build5:
	./scripts/build.sh leng-qie-jing 2>&1 | tee output/build-leng-qie-jing.log
	./scripts/build_pdf.sh leng-qie-jing 2>&1 | tee output/build-leng-qie-jing-pdf.log

all: clean
	./scripts/build-all.sh 2>&1 | tee output/build-all.log
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

font-list:
	fc-list

last_release_tag=0.6.0
content-files-changed:
	git diff --name-only $(last_release_tag) \
	src/books/jin-gang-jing/content.tex \
	src/books/xin-jing/content.tex \
	src/books/shi-xiao-zhou/content.tex \
	src/books/yao-shi-jing/content.tex \
	src/books/leng-qie-jing/content.tex \
	src/books/jin-gang-jing/meta.tex \
	src/books/xin-jing/meta.tex \
	src/books/shi-xiao-zhou/meta.tex \
	src/books/yao-shi-jing/meta.tex \
	src/books/leng-qie-jing/meta.tex 2>&1 | tee output/content-files-changed.log


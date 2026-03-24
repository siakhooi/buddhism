info:
build1:
	./scripts/generate-pinyin.sh xin-jing 2>&1 | tee output/build-xin-jing.log
	./scripts/build_pdf.sh xin-jing 2>&1 | tee output/build-xin-jing-pdf.log
build2:
	./scripts/generate-pinyin.sh jin-gang-jing 2>&1 | tee output/build-jin-gang-jing.log
	./scripts/build_pdf.sh jin-gang-jing 2>&1 | tee output/build-jin-gang-jing-pdf.log
build3:
	./scripts/generate-pinyin.sh shi-xiao-zhou 2>&1 | tee output/build-shi-xiao-zhou.log
	./scripts/build_pdf.sh shi-xiao-zhou 2>&1 | tee output/build-shi-xiao-zhou-pdf.log
build4:
	./scripts/generate-pinyin.sh yao-shi-jing 2>&1 | tee output/build-yao-shi-jing.log
	./scripts/build_pdf.sh yao-shi-jing 2>&1 | tee output/build-yao-shi-jing-pdf.log
build5:
	./scripts/generate-pinyin.sh leng-qie-jing 2>&1 | tee output/build-leng-qie-jing.log
	./scripts/build_pdf.sh leng-qie-jing 2>&1 | tee output/build-leng-qie-jing-pdf.log
build6:
	./scripts/generate-pinyin.sh zhuan-fa-lun-jing 2>&1 | tee output/build-zhuan-fa-lun-jing.log
	./scripts/build_pdf.sh zhuan-fa-lun-jing 2>&1 | tee output/build-zhuan-fa-lun-jing-pdf.log
build7:
	./scripts/generate-pinyin.sh wei-mo-jie-jing 2>&1 | tee output/build-wei-mo-jie-jing.log
	./scripts/build_pdf.sh wei-mo-jie-jing 2>&1 | tee output/build-wei-mo-jie-jing-pdf.log
all: clean build1 build2 build3 build4 build5 build6 build7
clean:
	rm -rf output www/books
release:
	./scripts/create-release.sh

last_release_tag=0.7.0
content-files-changed:
	git diff --name-only $(last_release_tag) \
	src/books/jin-gang-jing/content.tex \
	src/books/xin-jing/content.tex \
	src/books/shi-xiao-zhou/content.tex \
	src/books/yao-shi-jing/content.tex \
	src/books/leng-qie-jing/content.tex \
	src/books/zhuan-fa-lun-jing/content.tex \
	src/books/wei-mo-jie-jing/content.tex \
	src/books/jin-gang-jing/meta.tex \
	src/books/xin-jing/meta.tex \
	src/books/shi-xiao-zhou/meta.tex \
	src/books/yao-shi-jing/meta.tex \
	src/books/leng-qie-jing/meta.tex \
	src/books/zhuan-fa-lun-jing/meta.tex \
	src/books/wei-mo-jie-jing/meta.tex 2>&1 | tee output/content-files-changed.log

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

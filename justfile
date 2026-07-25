default:
  @just --list
build key:
	mkdir -p output
	./scripts/generate-pinyin.sh {{ key }} 2>&1 | tee output/build-{{ key }}.log
	./scripts/build_pdf.sh {{ key }} 2>&1 | tee output/build-{{ key }}-pdf.log

# build xin-jing
xj: (build "xin-jing")
# build jin-gang-jing
jgj: (build "jin-gang-jing")
# build shi-xiao-zhou
sxz: (build "shi-xiao-zhou")
# build yao-shi-jing
ysj: (build "yao-shi-jing")
# build zhuan-fa-lun-jing
zflj: (build "zhuan-fa-lun-jing")
# build wei-mo-jie-jing
wmjj: (build "wei-mo-jie-jing")
# build yi-jiao-jing
yjj: (build "yi-jiao-jing")
# build leng-qie-jing
lqj: (build "leng-qie-jing")
# build all
all: clean xj jgj sxz ysj lqj zflj wmjj yjj

clean:
	rm -rf output www/books
	mkdir -p output www/books
# release
release:
	./scripts/create-release.sh

last_release_tag := "0.9.0"
content-files-changed:
	git diff --name-only {{last_release_tag}} \
	src/books/jin-gang-jing/content.tex \
	src/books/xin-jing/content.tex \
	src/books/shi-xiao-zhou/content.tex \
	src/books/yao-shi-jing/content.tex \
	src/books/leng-qie-jing/content.tex \
	src/books/zhuan-fa-lun-jing/content.tex \
	src/books/wei-mo-jie-jing/content.tex \
	src/books/yi-jiao-jing/content.tex \
	src/books/jin-gang-jing/meta.tex \
	src/books/xin-jing/meta.tex \
	src/books/shi-xiao-zhou/meta.tex \
	src/books/yao-shi-jing/meta.tex \
	src/books/leng-qie-jing/meta.tex \
	src/books/zhuan-fa-lun-jing/meta.tex \
	src/books/wei-mo-jie-jing/meta.tex \
	src/books/yi-jiao-jing/meta.tex 2>&1 | tee output/content-files-changed.log

pdfinfo:
	pdfinfo www/books/xin-jing.pdf

font-list:
	fc-list

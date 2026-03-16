build: clean
	./scripts/build.sh xin-jing

pdfinfo:
	pdfinfo output/xin-jing/main.pdf

clean:
	rm -rf output
#!/bin/bash

usage() {
	echo "Usage: $(basename "$0") [-h] id"
}
while getopts "h" arg; do
	case $arg in
	h)
		usage
		exit 0
		;;
	*)
		usage
		exit 1
		;;
	esac
done
shift $((OPTIND - 1))
if [[ $# -ne 1 ]]; then
	usage
	exit 1
fi

readonly id=$1

sourceDir=$(realpath "src/books/$id")
if [[ ! -d "$sourceDir" ]]; then
	echo "Error: source directory '$sourceDir' does not exist" >&2
	exit 1
fi
outputDir="output/$id"
if [[ ! -d "$outputDir" ]]; then
	mkdir -p "$outputDir"
fi
outputDir=$(realpath "$outputDir")
wwwDir=$(realpath "www/books")
if [[ ! -d "$wwwDir" ]]; then
  mkdir -p "$wwwDir"
fi
main_template=$(realpath "src/template/main.tex")

# generate PDF
(
	cd "$sourceDir" || {
		echo "Error: failed to change directory to '$sourceDir'" >&2
		exit 1
	}
	xelatex -interaction=nonstopmode -output-directory="$outputDir" "$main_template"
  cp -v "$outputDir"/"$(basename "${main_template%.tex}.pdf")" "$wwwDir/$id.pdf"
)

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

configDir=$(realpath src/config)

set -e
# generate pinyin
scripts/generate_content.py "$configDir" "$sourceDir"
# generate meta
scripts/generate_meta.py "$sourceDir"

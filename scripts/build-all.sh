#!/bin/bash

# shellcheck disable=SC2045
for dir in $(ls ./src/books); do
	./scripts/build.sh "$dir"
	./scripts/build_pdf.sh "$dir"
done

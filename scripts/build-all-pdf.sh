#!/bin/bash

names=(
	xin-jing
	jin-gang-jing
	shi-xiao-zhou
	yao-shi-jing
	zhuan-fa-lun-jing
	leng-qie-jing
	wei-mo-jie-jing
)
# shellcheck disable=SC2045
for dir in "${names[@]}"; do
	./scripts/build_pdf.sh "$dir"
done

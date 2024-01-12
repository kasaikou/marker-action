#!/bin/sh

SRC=$1
DEST=$2
MAX_PAGES=$3

export DEFAULT_LANG=$4

.venv/bin/python convert_single.py ${GITHUB_WORKSPACE}/${SRC} ${GITHUB_WORKSPACE}/${DEST} --max_pages ${MAX_PAGES}
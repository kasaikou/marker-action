#!/bin/sh

cd $(dirname $0)

SRC=$1
DEST=$2
MAX_PAGES=$3

export DEFAULT_LANG=$4
export OCR_ENGINE=ocrmypdf

.venv/bin/python convert_single.py ${GITHUB_WORKSPACE}/${SRC} ${GITHUB_WORKSPACE}/${DEST}
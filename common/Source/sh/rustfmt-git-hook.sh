#!/bin/bash

for FILE in `git diff --cached --name-only`; do
    if [[ $FILE == *.rs ]] && ! rustfmt --write-mode diff --skip-children $FILE; then
        echo "Commit rejected due to invalid formatting of \"$FILE\" file."

        exit 1
    fi
done

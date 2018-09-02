#!/bin/bash

for FILE in `git diff --cached --name-only`; do
    if [[ $FILE == *.rs ]] && ! rustup run nightly rustfmt --check $FILE; then
        echo "Commit rejected due to invalid formatting of \"$FILE\" file."

        exit 1
    fi
done

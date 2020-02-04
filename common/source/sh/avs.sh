#!/bin/sh

if [ $# -ne 1 ]
then
	echo "Usage: $0 <video file>"
	exit 1
fi

cat >"${1%.*}".avs <<EOF
FFmpegSource2("$1")
EOF

#!/bin/sh

if [ $# -ne 1 ]
then
	echo "Usage: $0 <video file>"
	exit 1
fi

cat >"${1%.*}".vpy <<EOF
from vapoursynth import core
core.ffms2.Source('$1').set_output()
EOF

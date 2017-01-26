#! /usr/bin/bash
set -euo pipefail
IFS=$'\n\t'

function main {
	if [[ $# -ne "1" ]]; then
		echo "./wine.sh <link to wine source code>"
	else
		echo "Downloading and extracting the source code..."
		curl "$1" | tar xj

		local DIR=$(find -maxdepth 1 -type d -name "wine-*" | head -n1)

		echo "Patching mmdevdrv.c..."
		patch $DIR/dlls/winealsa.drv/mmdevdrv.c ~/Source/c/mmdevdrv.c.patch

		echo "Compiling winealsa.drv..."
		cd $DIR
		./configure --without-freetype
		make dlls/winealsa.drv

		echo "Copying winealsa.drv into the proper folder..."
		sudo cp {dlls/winealsa.drv,/usr/lib32/wine}/winealsa.drv.so

		echo "Removing the directory..."
		cd ..
		rm -rf $DIR
	fi
}

main $@

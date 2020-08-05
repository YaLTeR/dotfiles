#! /usr/bin/bash
set -euo pipefail
IFS=$'\n\t'

function main {
	if [[ $# -ne "1" ]]; then
		echo "./wine.sh <link to wine source code>"
	else
		echo "Downloading and extracting the source code..."
		curl "$1" | tar xJ

		local DIR
		DIR=$(find . -maxdepth 1 -type d -name "wine-*" | head -n1)

		echo "Patching ALSA mmdevdrv.c..."
		patch "$DIR"/dlls/winealsa.drv/mmdevdrv.c ~/source/c/alsa_mmdevdrv.c.patch

		echo "Patching Pulse mmdevdrv.c..."
		patch "$DIR"/dlls/winepulse.drv/mmdevdrv.c ~/source/c/pulse_mmdevdrv.c.patch

		echo "Configuting..."
		cd "$DIR"
		./configure --without-freetype

		echo "Compiling winealsa.drv and winepulse.drv..."
		make -j dlls/winepulse.drv

		echo "Copying winealsa.drv and winepulse.drv into the proper folder..."
		sudo cp {dlls/winepulse.drv,/usr/lib/wine}/winepulse.drv.so

		echo "Removing the directory..."
		cd ..
		rm -rf "$DIR"
	fi
}

main "$@"

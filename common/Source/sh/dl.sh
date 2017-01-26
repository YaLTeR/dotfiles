#!/usr/bin/bash

youtube-dl -f bestvideo[fps=60]+bestaudio/bestvideo+bestaudio/best "$1"
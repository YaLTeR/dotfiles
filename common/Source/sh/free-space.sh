#!/bin/sh

df -h --output=target,avail "$1" | sed -E '1d; s#^/\S*\s+##'

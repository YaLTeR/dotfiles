#!/bin/sh

df -h --output=target,avail / | sed -E '1d; s#^/\s+##'

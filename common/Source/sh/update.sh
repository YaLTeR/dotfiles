#!/usr/bin/bash

pacaur -Syu --noconfirm --devel --needed
flatpak --user update

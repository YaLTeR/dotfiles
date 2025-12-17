#!/bin/sh

exec podman generate systemd fedora-toolbox-43 > ~/.config/systemd/user/toolbox-container.service

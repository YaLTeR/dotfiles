efibootmgr -d /dev/sda -p 1 -c -L "Arch Linux nomodeset" -l /vmlinuz-linux -u "root=/dev/sda4 rw initrd=/initramfs-linux.img nomodeset"
efibootmgr -d /dev/sda -p 1 -c -L "Arch Linux" -l /vmlinuz-linux -u "root=/dev/sda4 rw initrd=/initramfs-linux.img nvidia-drm.modeset=1"

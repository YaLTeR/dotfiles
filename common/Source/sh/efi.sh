efibootmgr -d /dev/sda -p 1 -c -L "Arch Linux nomodeset" -l /vmlinuz-linux -u "root=PARTUUID=108d33d9-b33e-44c7-b35d-78cd007f739c rw initrd=/intel-ucode.img initrd=/initramfs-linux.img nomodeset"
efibootmgr -d /dev/sda -p 1 -c -L "Arch Linux" -l /vmlinuz-linux -u "root=PARTUUID=108d33d9-b33e-44c7-b35d-78cd007f739c rw initrd=/intel-ucode.img initrd=/initramfs-linux.img nvidia-drm.modeset=1"

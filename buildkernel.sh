#!/bin/sh

# Compile the kernel, embed the DTB and create an initrd, put everything in
# /boot

# TODO: Explore the possibility to us zImage instead of uImage

version=`make kernelversion`

make uImage
cp arch/arm/boot/zImage arch/arm/boot/zImage.orig
make dtbs
cat arch/arm/boot/zImage.orig arch/arm/boot/dts/dove-cubox.dtb > arch/arm/boot/zImage
make uImage
make modules
sudo make modules_install
sudo cp arch/arm/boot/uImage /boot/uImage-$version
sudo /usr/sbin/update-initramfs -k $version -c


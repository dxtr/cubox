#!/bin/sh

# Compile the kernel and embed the DTB, put everything in
# /boot

# TODO: Explore the possibility to use zImage instead of uImage

version=`make kernelversion`
dtb="dove-cubox.dtb"

cd /usr/src/linux-$version

echo "Building uImage and $dtb"
make uImage $dtb

echo "Making backup of zImage"
cp arch/arm/boot/zImage arch/arm/boot/zImage.orig

echo "Combining zImage and $dtb"
cat arch/arm/boot/zImage.orig arch/arm/boot/dts/$dtb > arch/arm/boot/zImage

echo "Making uImage"
make uImage

echo "Making modules"
make modules

echo "Installing moodules"
sudo make modules_install

echo "Copying uImage to /boot/uImage-$version"
sudo cp arch/arm/boot/uImage /boot/uImage-$version
#sudo /usr/sbin/update-initramfs -k $version -c


version=""
update_flags=""
if [ ! -z $1 ]; then
	version=$1
else
	version=`uname -r`
fi

echo $version

initrd="initrd.img-$version"

if [ -f /boot/$initrd ]; then
	update_flags="-u"
else
	update_flags="-c"
fi

update-initramfs -k $version $update_flags

mkimage -A arm -O linux -T ramdisk -C gzip -d /boot/initrd.img-$version /boot/uInitrd-$version

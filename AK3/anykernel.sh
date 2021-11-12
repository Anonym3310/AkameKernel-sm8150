# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=
do.devicecheck=0
do.modules=1
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=$(find /dev -name boot | head -n 1);
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;



## AnyKernel install
dump_boot;

write_boot;

#===[ AkameKernel add-ons start ]===#

#Mounting partitions

ui_print " "
ui_print "Mounting system and vendor"
ui_print " "
mount -o rw,remount /system
mount -o rw,remount /vendor
mount -o rw,remount /

#cp fw files

mkdir -p /system/etc/firmware/

ui_print "- Copying firmware to system/etc/firmware"

install "modules/system/etc/firmware" 0755 0644 "/system/etc/firmware";

#mkdir

mkdir -p /lib/modules/$(uname -r)

#install help magisk module & other

ui_print "Installing Magisk Module for Automaticly Activate (insmod) All Modules (*.ko-files) at Start Your Android"

cp -rf AutoInsmodModules /data/adb/modules/

#===[ End of the AkameKernel add-ons ]===#

## end install


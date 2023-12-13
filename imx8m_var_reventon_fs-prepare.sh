#!/bin/bash

echo "#### Reventon Carrier from Stonehex, starting customize fs ####"
CURRENT=`pwd`
OVERLAY_PATH=$CURRENT/board/stonehex/reventon/overlay
ROOTFS_PATH=$CURRENT/output/target
cp -a ${OVERLAY_PATH}/* ${ROOTFS_PATH}
IP=`hostname -I | awk '{print $1}'`
echo "REFERENCE_SERVER=$IP" > ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "BOOT_DEVICE=mmcblk1p1" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "KERNEL=Image" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "DTB=imx8mm-var-som-symphony.dtb" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "BOOTSCRIPT=boot.scr" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "FS=uInitrd" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars

echo "#### Reventon Carrier from Stonehex, customize fs done ####"


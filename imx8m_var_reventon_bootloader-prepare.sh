#!/bin/bash

echo "========= Reventon Carrier from Stonehex, starting create image process ========="
CURRENT=`pwd`
IMAGES_PATH=$1
UBOOT_PATH=$CURRENT/output/build/uboot-lf_v2023.04_var01
IMX_BOOT_TOOLS=imx-boot-tools
REV_PKG=SthRevVar_i.mx8m_1.0.0
cd $UBOOT_PATH

if [ ! -d ${BR2_DL_DIR}/${REV_PKG} ]; then
	echo "========= ${REV_PKG} cloning ========="
	pushd ${BR2_DL_DIR}
	git clone https://github.com/StoneHEX/${REV_PKG}.git
	popd
else
	echo "========= ${REV_PKG} present,updating	========="
	pushd ${BR2_DL_DIR}/${REV_PKG}
	git pull
	popd
fi
if [ ! -d ${BR2_DL_DIR}/${REV_PKG} ]; then
	echo "========= ${REV_PKG} not found	========="
	exit -1
fi

rm -rf $IMX_BOOT_TOOLS
mkdir $IMX_BOOT_TOOLS
cd $IMX_BOOT_TOOLS

cp ${BR2_DL_DIR}/${REV_PKG}/firmware-imx-8.20.bin .
chmod +x firmware-imx-8.20.bin
./firmware-imx-8.20.bin --auto-accept
cp firmware-imx-8.20/firmware/ddr/synopsys/* .

tar jxf ${BR2_DL_DIR}/${REV_PKG}/imx-mkimage_lf-6.1.22_2.0.0.tar.bz2
mv imx-mkimage_lf-6.1.22_2.0.0 imx-mkimage
cp imx-mkimage/iMX8M/*.c imx-mkimage/iMX8M/*.sh  imx-mkimage/scripts/*.sh .
cp dtb_check.sh ../scripts/

tar jxf ${BR2_DL_DIR}/${REV_PKG}/imx-atf_lf_v2.8_var01.tar.bz2
mv imx-atf_lf_v2.8_var01 imx-atf

tar jxf ${BR2_DL_DIR}/${REV_PKG}/meta-variscite-bsp-imx.tar.bz2

cd imx-mkimage
git apply ../meta-variscite-bsp-imx/recipes-bsp/imx-mkimage/imx-boot/0001-iMX8M-soc-allow-dtb-override.patch
git apply ../meta-variscite-bsp-imx/recipes-bsp/imx-mkimage/imx-boot/0002-iMX8M-soc-change-padding-of-DDR4-and-LPDDR4-DMEM-fir.patch
git apply ../meta-variscite-bsp-imx/recipes-bsp/imx-mkimage/imx-boot/0003-iMX8M-soc-add-variscite-imx8mm-support.patch
cp iMX8M/soc.mak ..
cd ..
echo "========= ATF ========="
cd imx-atf 
source ${CURRENT}/output/build/${REV_PKG}/SourceMe64
unset LDFLAGS
make PLAT=imx8mm bl31
cp build/imx8mm/release/bl31.bin ..
cd ..
cp ../tools/mkimage mkimage_uboot
cp ../u-boot.bin .
cp ../u-boot-nodtb.bin ../spl/u-boot-spl.bin ../arch/arm/dts/imx8mm-var-dart-customboard.dtb ../arch/arm/dts/imx8mm-var-som-symphony.dtb  .
echo "========= MKIMAGE ========="
make -f soc.mak clean
make -f soc.mak SOC=iMX8MM SOC_DIR=$IMX_BOOT_TOOLS dtbs="imx8mm-var-dart-customboard.dtb imx8mm-var-som-symphony.dtb " MKIMG=./mkimage_imx8 PAD_IMAGE=./pad_image.sh CC=gcc OUTIMG=$CURRENT/output/images/imx8-boot-sd.bin flash_lpddr4_ddr4_evk 
echo "========= FILE SYSTEM AND BOOT.SCR ========="
cd ${CURRENT}
output/host/usr/bin/mkimage -A arm -O linux -T ramdisk -C none -n "uInitrd" -a 0x80000 -d output/images/rootfs.ext2.gz output/images/uInitrd
output/host/usr/bin/mkimage -C none -A arm -T script -d ${BR2_DL_DIR}/${REV_PKG}/boot_script output/images/boot.scr
echo "========= Reventon Carrier from Stonehex , image done ========="



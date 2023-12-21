# SthRevVar_i.mx8m_1.0.0<br>
## Variscite i.mx8m on Stonehex Reventon carrier board patches
This repo provides the patches and necessary files to patch buildroot 2023.08.4.<br>
The files are stored on this repo to have something stable and checked trough variations in the cloned repositories.<br>
The repositories are:<br>
A: u-boot : <b>git clone https://github.com/varigit/uboot-imx.git -b lf_v2023.04_var01</b> ( provided in buildroot configuration )<br>
B: firmware-imx : <b>wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.20.bin</b><br>
C: imx-mkimage : <b>git clone https://github.com/nxp-imx/imx-mkimage -b lf-6.1.22_2.0.0</b><br>
D: imx-atf : <b>git clone https://github.com/varigit/imx-atf -b lf_v2.8_var01</b><br>
E: meta-variscite-bsp-imx : provided a fixed version fron Stonehex repo ( this )<br>

## Quick instructions:

1: clone buildroot : <b>git clone https://github.com/buildroot/buildroot.git</b><br>
2: download <b>var_reventon_br-2023.08.4_001.patch</b> from here :<br>**** https://github.com/StoneHEX/SthRevVar_i.mx8m_1.0.0/blob/master/var_reventon_br-2023.08.4_001.patch ****<br>
3: rename buildroot obtained directory in step 1 with the name you like and enter it<br>
4: checkout branch 2023.08.4 : <b>git checkout 2023.08.4</b><br>
5: apply patch with <b>patch -p1 < ../var_reventon_br-2023.08.4_001.patch</b><br>
6: configure with <b>make var_reventon_i.mx8m_sth_defconfig</b><br>
7: make with <b>make</b><br>
### WARNING : check your device is /dev/sdb , mksd.sh defaults to it so change it if different !!!
### WARNING : selecting the wrong device can destroy your hard disk
8: create sd card with <b>mksd.sh</b><br>

## Notes
The packages are downloaded in the directory specified by buildroot configurations, default is /Devel/buildroot/Downloads.<br>
For different download directory enter the menu configuration <b>make menuconfig</b> after the above step 5 ( <b>make var_reventon_i.mx8m_sth_defconfig</b> )<br>
This will modify your buildroot configuration file but not the default one ( <b>var_reventon_i.mx8m_sth_defconfig</b> ), if you prefer to make the changes
 permanent copy the <b>.config</b> file in the configs directory, e.g. <b>cp .config configs/var_reventon_i.mx8m_sth_defconfig</b>

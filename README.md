# SthRevVar_i.mx8m_1.0.0<br>
Quick instructions:<br>
1: clone buildroot : <b>git clone --branch 2023.08.4 https://github.com/buildroot/buildroot.git</b><br>
2: rename buildroot obtained directory with the name you like and enter it<br>
3: download <b>var_reventon_br-2023.08.4_001.patch</b><br>
4: apply patch with <b>patch -p1 < var_reventon_br-2023.08.4_001.patch</b><br>
5: configure with <b>make variscite_reventon_defconfig</b><br>
6: make with <b>make</b><br>
### WARNING : check your device is /dev/sdb , mksd.sh defaults to it !!!
7: create sd card with <b>mksd.sh</b><br>

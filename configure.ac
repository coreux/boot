## Copyright 2014 Mo McRoberts.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.

AC_INIT([include],[master],[https://github.com/coreux/boot/issues],,[https://github.com/coreux/boot])
AC_CONFIG_AUX_DIR([.])
AC_CONFIG_MACRO_DIR([.])
AM_INIT_AUTOMAKE([foreign])
AM_MAINTAINER_MODE
AC_CANONICAL_HOST
AC_PROG_CC


AC_MSG_CHECKING([whether $host_cpu-$host_vendor is a supported boot architecture])

build_syslinux=no
boot_arch=no
case "$host_cpu-$host_vendor" in
	 i?86-pc|i?86-unknown)
		boot_arch=x86-pc
		openbios_arch=x86
		build_syslinux=yes
		;;
	 x86_64-pc|amd64-pc|x86_64-unknown|amd64-unknown)
#	    boot_arch=amd64-pc
		boot_arch=x86-pc
		openbios_arch=x86
		build_syslinux=yes
		;;
esac

if test $boot_arch = no ; then
   AC_MSG_RESULT([no])
   boot_arch=""
else
   AC_MSG_RESULT([yes])
fi

AC_SUBST([boot_arch])
AC_SUBST([openbios_arch])

# if test $build_syslinux = yes ; then
   # Check for NASM
   # Check for uuid-dev   
# fi

bootdir="/boot"
AC_SUBST([bootdir])

bootarchdir="$bootdir/$boot_arch"
AC_SUBST([bootarchdir])

XSLTPROC=xsltproc
AC_SUBST([XSLTPROC])

$MKDIR_P $boot_arch/target
$MKDIR_P $boot_arch/target/include
$MKDIR_P $boot_arch/target/arch
$MKDIR_P $boot_arch/target/arch/unix
$MKDIR_P $boot_arch/target/arch/$openbios_arch
$MKDIR_P $boot_arch/target/libgcc
$MKDIR_P $boot_arch/target/kernel
$MKDIR_P $boot_arch/target/libopenbios
$MKDIR_P $boot_arch/target/packages
$MKDIR_P $boot_arch/target/fs
$MKDIR_P $boot_arch/target/fs/grubfs
$MKDIR_P $boot_arch/target/fs/hfs
$MKDIR_P $boot_arch/target/fs/hfsplus
$MKDIR_P $boot_arch/target/fs/iso9660
$MKDIR_P $boot_arch/target/fs/ext2
$MKDIR_P $boot_arch/target/drivers
$MKDIR_P $boot_arch/target/libc
$MKDIR_P $boot_arch/host/include
$MKDIR_P $boot_arch/host/kernel
$MKDIR_P $boot_arch/forth

cp $srcdir/openbios/config/xml/rules.xml $boot_arch/rules.xml
rm -f $boot_arch/target/include/asm
obtop="`(cd $srcdir && pwd)`"
ln -s "$obtop/openbios/include/arch/$openbios_arch" $boot_arch/target/include/asm

AC_CONFIG_FILES([
Makefile
x86-pc/Makefile
x86-pc/config.mak
x86-pc/config.xml
])

AC_OUTPUT

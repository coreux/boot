## Build logic for the x86-pc boot architecture

all-local: all-syslinux-bios all-openbios
clean-local: clean-syslinux
distclean-local: clean-syslinux distclean-openbios
install-data-local: install-syslinux-cdfs install-syslinux-pxe install-syslinux-dosfs install-syslinux-btrfs install-syslinux-extfs install-syslinux-com32 install-syslinux-mbr install-openbios

EXTRA_DIST = config.xml.in config.mak.in

# CLEANFILES must be set before it can be added to by included Makefile
# fragments, so we 'clean' a dummy file

CLEANFILES = cleanfiles.dummy.am
DISTCLEANFILES = config.xml config.mak

dist_bootarch_DATA = stage1.cfg

include $(top_srcdir)/syslinux-bios.mk
include $(top_srcdir)/openbios.mk


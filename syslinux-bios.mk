## Build rules for the BIOS- and PXE-loaded variants of SYSLINUX, as well
## as the COM32 executables and stock MBRs.

MBR = altmbr.bin altmbr_c.bin altmbr_f.bin gptmbr.bin gptmbr_c.bin gptmbr_f.bin isohdpfx.bin isohdpfx_c.bin isohdpfx_f.bin isohdppx.bin isohdppx_c.bin isohdppx_f.bin mbr.bin mbr_c.bin mbr_f.bin

CLEANFILES += version.mk

all-syslinux-bios:
	$(MKDIR_P) bios
	(cd $(top_srcdir)/syslinux && $(MAKE) O='$(abs_builddir)' bios)

clean-syslinux:
	-(cd $(top_srcdir)/syslinux && $(MAKE) O='$(abs_builddir)' clean)
	-rm -rf bios

install-syslinux-cdfs:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)/cdfs
	$(INSTALL_DATA) bios/core/isolinux.bin $(DESTDIR)$(bootarchdir)/cdfs/stage1.bin

install-syslinux-pxe:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)/pxe
	$(INSTALL_DATA) bios/core/lpxelinux.0 $(DESTDIR)$(bootarchdir)/pxe/stage1.pxe

install-syslinux-dosfs:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)/dosfs
	$(INSTALL_DATA) bios/core/ldlinux.bss $(DESTDIR)$(bootarchdir)/dosfs/stage0.bin
	$(INSTALL_DATA) bios/core/ldlinux.sys $(DESTDIR)$(bootarchdir)/dosfs/stage1.sys

install-syslinux-extfs:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)/extfs
	$(INSTALL_DATA) bios/core/ldlinux.bss $(DESTDIR)$(bootarchdir)/extfs/stage0.bin
	$(INSTALL_DATA) bios/core/ldlinux.sys $(DESTDIR)$(bootarchdir)/extfs/stage1.sys

install-syslinux-btrfs:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)/btrfs
	$(INSTALL_DATA) bios/core/ldlinux.bss $(DESTDIR)$(bootarchdir)/btrfs/stage0.bin
	$(INSTALL_DATA) bios/core/ldlinux.sys $(DESTDIR)$(bootarchdir)/btrfs/stage1.sys

install-syslinux-com32:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)
	$(INSTALL_DATA) bios/com32/elflink/ldlinux/ldlinux.c32 $(DESTDIR)$(bootarchdir)/ldlinux.c32
	$(INSTALL_DATA) bios/com32/lib/libcom32.c32 $(DESTDIR)$(bootarchdir)/libcom32.c32
	$(INSTALL_DATA) bios/com32/libutil/libutil.c32 $(DESTDIR)$(bootarchdir)/libutil.c32
	$(INSTALL_DATA) bios/com32/mboot/mboot.c32 $(DESTDIR)$(bootarchdir)/mboot.c32

install-syslinux-mbr:
	$(MKDIR_P) $(DESTDIR)$(libexecdir)/boot/$(boot_arch)
	for i in $(MBR) ; do $(INSTALL_DATA) bios/mbr/$$i $(DESTDIR)$(libexecdir)/boot/$(boot_arch)/$$i ; done

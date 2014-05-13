## Build logic for the x86-pc boot architecture

all-local: all-syslinux-bios all-openbios
clean-local: clean-syslinux
distclean-local: clean-syslinux
install-data-local: install-syslinux-cdfs install-syslinux-pxe install-syslinux-dosfs install-syslinux-btrfs install-syslinux-extfs install-syslinux-com32 install-syslinux-mbr install-openbios

MBR = altmbr.bin altmbr_c.bin altmbr_f.bin gptmbr.bin gptmbr_c.bin gptmbr_f.bin isohdpfx.bin isohdpfx_c.bin isohdpfx_f.bin isohdppx.bin isohdppx_c.bin isohdppx_f.bin mbr.bin mbr_c.bin mbr_f.bin

EXTRA_DIST = config.xml.in config.mak.in

DISTCLEANFILES = rules.xml build.xml build-full.xml rules.mak

dist_bootarch_DATA = stage1.cfg

all-syslinux-bios:
	$(MKDIR_P) bios
	cd $(top_srcdir)/syslinux && $(MAKE) O='$(abs_builddir)' bios

all-openbios: rules.mak host/include/autoconf.h target/include/autoconf.h forth/config.fs
	$(MAKE) -f $(abs_top_srcdir)/openbios/Makefile.target build-verbose V=1

build-full.xml: $(top_srcdir)/openbios/config/xml/xinclude.xsl $(top_srcdir)/openbios/build.xml
	$(XSLTPROC) $(top_srcdir)/openbios/config/xml/xinclude.xsl $(top_srcdir)/openbios/build.xml > build-full.xml

rules.mak: $(top_srcdir)/openbios/config/xml/makefile.xsl build-full.xml
	$(XSLTPROC) $(top_srcdir)/openbios/config/xml/makefile.xsl build-full.xml > rules.mak

host/include/autoconf.h: $(top_srcdir)/openbios/config/xml/config-c.xsl config.xml
	$(XSLTPROC) $(top_srcdir)/openbios/config/xml/config-c.xsl config.xml > host/include/autoconf.h

target/include/autoconf.h: $(top_srcdir)/openbios/config/xml/config-c.xsl config.xml
	$(XSLTPROC) $(top_srcdir)/openbios/config/xml/config-c.xsl config.xml > target/include/autoconf.h

forth/config.fs: $(top_srcdir)/openbios/config/xml/config-forth.xsl config.xml
	$(XSLTPROC) $(top_srcdir)/openbios/config/xml/config-forth.xsl config.xml > forth/config.fs

clean-syslinux:
	-(cd $(top_srcdir)/syslinux && $(MAKE) O='$(abs_top_builddir)/syslinux' clean)
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

install-openbios:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)
	$(INSTALL_DATA) openbios-builtin.elf $(DESTDIR)$(bootarchdir)/bootload.elf

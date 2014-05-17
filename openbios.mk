## Build rules for OpenBIOS

DISTCLEANFILES += rules.xml build.xml

CLEANFILES += \
	rules.mak host/include/autoconf.h target/include/autoconf.h \
	forth/config.fs build-full.xml \
	QEMU,VGA.bin forthstrap \
	bootstrap.dict bootstrap.dict.d \
	openbios-x86.dict openbios-x86.dict-console.log openbios-x86.dict.d \
	openbios.dict openbios.dict-console.log openbios-dict.d \
	openbios-builtin.elf openbios-builtin.elf.nostrip \
	openbios-builtin.syms \
	openbios.multiboot openbios.multiboot.nostrip \
	openbios-multiboot.syms \
	libbootstrap.a libfs.a liblibc.a libpackages.a libdrivers.a \
	libgcc.a libopenbios.a libx86.a

all-openbios: rules.mak host/include/autoconf.h target/include/autoconf.h forth/config.fs
	$(MAKE) -f $(abs_top_srcdir)/openbios/Makefile.target build-verbose V=1

install-openbios:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)
	$(INSTALL_DATA) openbios-builtin.elf $(DESTDIR)$(bootarchdir)/bootload.elf

distclean-openbios:
	rm -rf forth host target

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


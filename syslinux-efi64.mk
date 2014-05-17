## Build rules for the x86-64 EFI64 variant of SYSLINUX
##
## Note that these rules are primarily intended to be used alongside
## those in syslinux-bios.mk, rather than as an alternative to them
## (the COM32 executables are only installed by syslinux-bios.mk -- this
## version only installs the EFI executable)

EFI64DIR = $(abs_top_srcdir)/syslinux/gnu-efi/gnu-efi-3.0

all-syslinux-efi64:
	$(MKDIR_P) efi64/gnu-efi
	( cd efi64/gnu-efi && $(MAKE) SRCDIR="$(EFI64DIR)" TOPDIR="$(EFI64DIR)" ARCH=x86_64 -f $(EFI64DIR)/Makefile )
	( cd efi64/gnu-efi && $(MAKE) SRCDIR="$(EFI64DIR)" TOPDIR="$(EFI64DIR)" ARCH=x86_64 PREFIX="$(abs_builddir)/efi64" -f $(EFI64DIR)/Makefile install )
	( cd $(top_srcdir)/syslinux && $(MAKE) O='$(abs_builddir)' efi64)

install-syslinux-efi64:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)/efi64
	$(INSTALL_DATA) efi64/efi/syslinux.efi $(DESTDIR)$(bootarchdir)/efi64/stage1.efi

clean-syslinux-efi64: clean-syslinux
	-rm -rf efi64

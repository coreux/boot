## Build rules for the EFI32 variant of SYSLINUX
##
## Note that these rules are primarily intended to be used alongside
## those in syslinux-bios.mk, rather than as an alternative to them
## (the COM32 executables are only installed by syslinux-bios.mk -- this
## version only installs the EFI executable)

EFI32DIR = $(abs_top_srcdir)/syslinux/gnu-efi/gnu-efi-3.0

all-syslinux-efi32:
	$(MKDIR_P) efi32/gnu-efi
	( cd efi32/gnu-efi && $(MAKE) SRCDIR="$(EFI32DIR)" TOPDIR="$(EFI32DIR)" ARCH=ia32 -f $(EFI32DIR)/Makefile )
	( cd efi32/gnu-efi && $(MAKE) SRCDIR="$(EFI32DIR)" TOPDIR="$(EFI32DIR)" ARCH=ia32 PREFIX="$(abs_builddir)/efi32" -f $(EFI32DIR)/Makefile install )
	( cd $(top_srcdir)/syslinux && $(MAKE) O='$(abs_builddir)' efi32)

install-syslinux-efi32:
	$(MKDIR_P) $(DESTDIR)$(bootarchdir)/efi32
	$(INSTALL_DATA) efi32/efi/syslinux.efi $(DESTDIR)$(bootarchdir)/efi32/stage1.efi

clean-syslinux-efi32: clean-syslinux
	-rm -rf efi32

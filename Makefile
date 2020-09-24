PROJECT_NAME:=mlxbf-aarch64-firmware
LIBDIR = /lib

# Default target.
all:

include $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))/package.mk

# By default, use the Makefile's directory as the vpath.
VPATH := $(dir $(lastword $(MAKEFILE_LIST)))

INSTALLDIR:=$(LIBDIR)/firmware/mellanox/boot

uninstall:
	rm -rf $(DESTDIR)$(INSTALLDIR)

install:
	mkdir -p $(DESTDIR)$(INSTALLDIR)
	rsync -avz --perms=644 bootimages/ $(DESTDIR)$(INSTALLDIR)

.PHONY: all install uninstall

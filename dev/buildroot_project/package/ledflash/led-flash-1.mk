################################################################################
#
# Buildroot "led-flash-1" module.
#
################################################################################

LEDFLASH_VERSION:= 1.0.0
LEDFLASH_SITE_METHOD=file
LEDFLASH_SITE:=/home/abdallah/dev/formation/boards/beaglebone/dev/buildroot_project/package
#LEDFLASH_ARCH = $(if $(BR2_i386),i386)$(if $(BR2_x86_64),x86_64)
LEDFLASH_INSTALL_TARGET:=YES
LEDFLASH_DEPENDENCIES = linux

define LEDFLASH_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
endef

define LEDFLASH_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR) modules_install
endef

$(eval $(generic-package))

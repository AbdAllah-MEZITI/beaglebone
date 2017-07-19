################################################################################
#
# Buildroot "Hello" module.
#
################################################################################

HELLO_VERSION:= 1.0.0
HELLO_SITE_METHOD=file
HELLO_SITE:=/home/abdallah/dev/formation/boards/beaglebone/dev/buildroot_project/package
#HELLO_ARCH = $(if $(BR2_i386),i386)$(if $(BR2_x86_64),x86_64)
HELLO_INSTALL_TARGET:=YES
HELLO_DEPENDENCIES = linux

define HELLO_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
endef

define HELLO_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR) modules_install
endef

$(eval $(generic-package))

################################################################################
#
# led-flash-module
#
################################################################################

LED_FLASH_MODULE_VERSION     = 1.0.0
LED_FLASH_MODULE_SITE        = https://github.com/AbdAllah-MEZITI/beaglebone/tree/master/dev/buildroot/package/khaymatec/ledflash.git
LED_FLASH_MODULE_SITE_METHOD = git
LED_FLASH_MODULE_DEPENDENCIES = linux

define LED_FLASH_MODULE_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
endef

define LED_FLASH_MODULE_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR) modules_install
endef

$(eval $(generic-package))

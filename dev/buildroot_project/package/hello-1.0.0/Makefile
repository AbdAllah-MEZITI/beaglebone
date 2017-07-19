ifneq (${KERNELRELEASE},)
	obj-m += hello.o
else
	ARCH		?= arm
	KERNEL_DIR	?= /home/abdallah/dev/formation/boards/beaglebone/dev/buildroot/output/build/linux-4.6
	CROSS_COMPILE	?= arm-linux-gnueabi-
	MODULE_DIR	:= $(shell pwd)
	CFLAGS		:= -Wall

all: modules

modules:
	${MAKE} -C ${KERNEL_DIR} ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} SUBDIRS=${MODULE_DIR} modules

modules_install:
	${MAKE} ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} INSTALL_MOD_PATH=${INSTALL_MOD_PATH} -C ${KERNELDIR} SUBDIRS=${MODULE_DIR} modules_install

clean:
	rm -f *.o .*.o .*.o.* *.ko .*.ko *.mod.* .*.mod.* .*.cmd
	rm -f Module.symvers Module.markers modules.order
	rm -rf .tmp_versions
endif

ifneq (${KERNELRELEASE},)
	obj-m += led-flash-1.o
else
	ARCH		?= arm
	KERNEL_DIR	?= /home/abdallah/dev/formation/boards/beaglebone/dev/linux
	CROSS_COMPILE	?= arm-linux-gnueabi-
	MODULE_DIR	:= $(shell pwd)
	CFLAGS		:= -Wall

all: modules

modules:
	${MAKE} -C ${KERNEL_DIR} ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} SUBDIRS=${MODULE_DIR} modules

clean:
	rm -f *.o .*.o .*.o.* *.ko .*.ko *.mod.* .*.mod.* .*.cmd
	rm -f Module.symvers Module.markers modules.order
	rm -rf .tmp_versions
endif

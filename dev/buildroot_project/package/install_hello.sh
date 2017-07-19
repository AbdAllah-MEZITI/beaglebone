#!/bin/bash

PACKAGE_NAME=hello
PACKAGE_RELEASE=1.0.0

BUILDROO_PATH=../../buildroot

rm -rf      ${BUILDROO_PATH}/package/${PACKAGE_NAME}
cp -rf      ${PACKAGE_NAME} ${BUILDROO_PATH}/package/

rm -rf      ${BUILDROO_PATH}/output/build/${PACKAGE_NAME}-${PACKAGE_RELEASE}
rm          ${BUILDROO_PATH}/dl/${PACKAGE_NAME}-${PACKAGE_RELEASE}.tar.gz

rm          ${PACKAGE_NAME}-${PACKAGE_RELEASE}.tar.gz
tar -zcvf   ${PACKAGE_NAME}-${PACKAGE_RELEASE}.tar.gz ${PACKAGE_NAME}-${PACKAGE_RELEASE}

# result : buildroot/output/target/lib/modules/4.6.0/extra/hello.ko

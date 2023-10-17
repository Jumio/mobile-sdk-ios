#!/bin/bash
JUMIO_SDK_VERSION=4.8.0
DOWNLOAD_PATH=https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/${JUMIO_SDK_VERSION}/ios-jumio-mobile-sdk-${JUMIO_SDK_VERSION}.zip
FRAMEWORK_DIR=${PROJECT_DIR}/Frameworks
FRAMEWORK_ZIP=${FRAMEWORK_DIR}/frameworks.zip

if [ -d ${FRAMEWORK_DIR}/Jumio/Jumio.xcframework ]; then
    echo "Jumio frameworks already available (see ${FRAMEWORK_DIR})"
    exit 0
fi

rm -rf ${FRAMEWORK_DIR}
mkdir ${FRAMEWORK_DIR}
curl -n --connect-timeout 5 -o ${FRAMEWORK_ZIP} --fail ${DOWNLOAD_PATH}

if [ -f ${FRAMEWORK_ZIP} ]; then
    unzip ${FRAMEWORK_ZIP} -d ${FRAMEWORK_DIR}
    rm ${FRAMEWORK_ZIP}
    
    if [ -d ${FRAMEWORK_DIR}/Jumio.xcframework ]; then
    mkdir ${FRAMEWORK_DIR}/Jumio
    cp -r ${FRAMEWORK_DIR}/Jumio.xcframework ${FRAMEWORK_DIR}/Jumio/Jumio.xcframework
    fi
else
    echo "error: Unable to retrieve latest Jumio SDK ${JUMIO_SDK_VERSION} for iOS"
    exit 1
fi

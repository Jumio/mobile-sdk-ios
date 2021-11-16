#!/bin/bash
JUMIO_SDK_VERSION=4.0.0
DOWNLOAD_PATH=https://mobile-sdk.jumio.com/com/jumio/ios/jumio-mobile-sdk/${JUMIO_SDK_VERSION}/ios-jumio-mobile-sdk-${JUMIO_SDK_VERSION}.zip
FRAMEWORK_DIR=${PROJECT_DIR}/Frameworks
FRAMEWORK_ZIP=${FRAMEWORK_DIR}/frameworks.zip

if [ -d ${FRAMEWORK_DIR}/Jumio+Liveness/Jumio.xcframework ]; then
    if grep ${JUMIO_SDK_VERSION} ${FRAMEWORK_DIR}/Jumio+Liveness/Jumio.xcframework/ios-arm64/Jumio.framework/Info.plist; then
        echo "Jumio frameworks already available (see ${FRAMEWORK_DIR})"
        exit 0
    fi
fi

rm -rf ${FRAMEWORK_DIR}
mkdir ${FRAMEWORK_DIR}
curl -n --connect-timeout 5 -o ${FRAMEWORK_ZIP} --fail ${DOWNLOAD_PATH}

if [ -f ${FRAMEWORK_ZIP} ]; then
    unzip ${FRAMEWORK_ZIP} -d ${FRAMEWORK_DIR}
    rm ${FRAMEWORK_ZIP}
else
    echo "error: Unable to retrieve latest Jumio SDK ${JUMIO_SDK_VERSION} for iOS"
    exit 1
fi

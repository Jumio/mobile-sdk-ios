#!/bin/bash
JUMIO_SDK_VERSION=2.15.0
DOWNLOAD_PATH=https://mobile-sdk.jumio.com/com/jumio/ios/jumio-mobile-sdk/${JUMIO_SDK_VERSION}/ios-jumio-mobile-sdk-${JUMIO_SDK_VERSION}.zip
CHECKOUT_DIR="${PROJECT_DIR}/JUMIO_DOWNLOAD"
FRAMEWORKS_DIR="${PROJECT_DIR}/../frameworks"

if [ -d "${FRAMEWORKS_DIR}" ]; then
	echo "Jumio frameworks already available (see ${FRAMEWORKS_DIR})"
else
	curl --connect-timeout 5 -o "$PROJECT_DIR/frameworks.zip" "${DOWNLOAD_PATH}"

	if [ -f "$PROJECT_DIR/frameworks.zip" ]; then
		unzip "$PROJECT_DIR/frameworks.zip" -d "${CHECKOUT_DIR}"
		rm -f frameworks.zip
		SDK_DIR=`find ${CHECKOUT_DIR}/JumioMobileSDK* -maxdepth 0`
		mv "${SDK_DIR}" "${FRAMEWORKS_DIR}"
		rm -rf "${CHECKOUT_DIR}"
	else
		echo "error: Unable to retrieve latest Jumio Mobile SDK ${JUMIO_SDK_VERSION} for iOS"
		exit 1
	fi		
fi

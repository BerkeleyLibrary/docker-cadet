#!/bin/bash

echo "Checking EULA acceptance..." 

if [[ ${CADET_ACCEPT_EULA} =~ ^[Yy] ]]; then
    if [ ! -d /opt/app/cadet ]; then 
        echo "Confirmed! Installing CADET..."
        curl -O http://ncamftp.wgbh.org/cadet/cadet-${CADET_VERSION}.zip
        unzip cadet-${CADET_VERSION}.zip
    else
        echo "Confirmed! Previous CADET installation found."
        INSTALLED_VERSION=`awk '/^var\ VERSION/ {gsub(/"/, "", $4);print $4}' /opt/app/cadet/cadet-resources/cadetdata.js`
        if [ ! "$CADET_VERSION" = "$INSTALLED_VERSION" ]; then
            echo "WARNING: Installed version ${INSTALLED_VERSION} does not match ${CADET_VERSION}, which was to be installed."
        fi
    fi
    exit 0
fi

echo ""
echo "Please confirm you accept the CADET EULA to continue:"
echo "http://ncamftp.wgbh.org/cadet/cadet-eula.html"
echo ""
echo "Then restart the container with CADET_ACCEPT_EULA set to 'y' or 'Y'." 
exit 1
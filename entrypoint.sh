#!/bin/bash
cd /home/container

# Output Current Java Version
java -version

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Downloads the custom jar
DOWNLOAD_URL="https://papermc.io/api/v1/${SERVER_TYPE}/${MINECRAFT_VERSION}/latest/download"
echo "Download Jar file from ${DOWNLOAD_URL}"
curl -s -o ${SERVER_JARFILE} ${DOWNLOAD_URL} > /dev/null

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}

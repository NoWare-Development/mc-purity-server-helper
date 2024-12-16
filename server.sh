#!/bin/bash

# NOTE: If you want to change memory settings, edit these lines:
MEMORY_MIB_MAX=2048
MEMORY_MIB_MIN=2048

# WARNING: `wget' and `unzip' must be installed before running this script!

ZULU_DIR="zulu8.76.0.17-ca-jdk8.0.402-linux_x64"
ZULU_JDK_ZIP_ARCHIVE="$ZULU_DIR.zip"
ZULU_JDK_URL="https://cdn.azul.com/zulu/bin/$ZULU_JDK_ZIP_ARCHIVE"
ZULU="$ZULU_DIR/bin/java"

PURITY_SERVER="purity_server.jar"
PURITY_SERVER_DIR="server"
PURITY_SERVER_URL="https://github.com/NoWare-Development/mc-purity/releases/latest/download/$PURITY_SERVER"

# Check if java files don't exist.
# If so, install them.
echo "Checking for java files..."
if [ ! -d $ZULU_DIR ]; then
  echo "Downloading java..."
  wget $ZULU_JDK_URL
  unzip $ZULU_JDK_ZIP_ARCHIVE
  rm $ZULU_JDK_ZIP_ARCHIVE
  echo "Java has been downloaded successfully."
fi

# Check if server file don't exist.
# If so, install it.
echo "Checking for server file..."
if [ ! -d $PURITY_SERVER_DIR ]; then
  echo "Downloading server..."
  mkdir $PURITY_SERVER_DIR
  wget $PURITY_SERVER_URL
  mv $PURITY_SERVER $PURITY_SERVER_DIR/$PURITY_SERVER
  echo "Server has been downloaded successfully."
fi

# Enter server directory
cd $PURITY_SERVER_DIR

# Run server
./../$ZULU -Xms${MEMORY_MIB_MIN}M -Xmx${MEMORY_MIB_MAX}M -jar $PURITY_SERVER nogui

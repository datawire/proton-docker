#!/bin/bash

TEMP_DIR=$(mktemp -d)
ORIGIN=$(pwd)
cd $TEMP_DIR

git clone https://git-wip-us.apache.org/repos/asf/qpid-proton.git proton
cd ./proton

rm -rf build
mkdir build
cd build

# Set the install prefix. You may need to adjust depending on your
# system.
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DSYSINSTALL_BINDINGS=ON

# Omit the docs target if you do not wish to build or install
# documentation.
make all docs

# Note that this step will require root privileges.
make install

# ws2tcp
echo "Setting up ws2tcp..."
rm -rf /usr/local/src/ws2tcp
mkdir /usr/local/src/ws2tcp
cp ../examples/messenger/javascript/ws2tcp.js /usr/local/src/ws2tcp/ws2tcp.js
cp ../examples/messenger/javascript/proxy.js /usr/local/src/ws2tcp/proxy.js
mv /opt/ws2tcp.sh /usr/local/src/ws2tcp/ws2tcp_proxy.sh
chmod +x /usr/local/src/ws2tcp/ws2tcp_proxy.sh
cp -s /usr/local/src/ws2tcp/ws2tcp_proxy.sh /usr/local/bin/ws2tcp_proxy

cd /usr/local/src/ws2tcp
npm install --save ws

echo "Setup of ws2tcp complete."

cd $ORIGIN
rm -rf $TEMP_DIR


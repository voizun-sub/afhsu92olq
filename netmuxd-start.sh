#!/bin/bash
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
apt update 
apt upgrade -y
apt install -y \
    libavahi-compat-libdnssd-dev \
    ninja-build \
    ldc \
    libgtk-3-0 \
    dub \
    build-essential \
    pkg-config \
    checkinstall \
    git \
    autoconf \
    automake \
    libtool-bin \
    usbmuxd
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
. "$HOME/.cargo/env"
rustup toolchain install stable 
rustup default stable 
git clone https://github.com/libimobiledevice/libplist.git 
cd libplist 
./autogen.sh 
make -j4 > /dev/null
make install 
cd ../ 
git clone https://github.com/libimobiledevice/libimobiledevice-glue.git 
cd libimobiledevice-glue 
./autogen.sh 
make -j4 > /dev/null
make install 
cd ../ 
git clone https://github.com/libimobiledevice/libusbmuxd.git 
cd libusbmuxd 
./autogen.sh 
make -j4 > /dev/null
make install 
cd ../ 
git clone https://github.com/libimobiledevice/libimobiledevice.git 
cd libimobiledevice 
./autogen.sh 
make -j4 > /dev/null
make install 
cd ../ 
git clone https://github.com/openssl/openssl.git 
cd openssl 
./Configure 
make -j4 > /dev/null
make install > /dev/null
cd ../ 
git clone https://github.com/jkcoxson/netmuxd.git 
cd netmuxd 
cargo build --bin netmuxd

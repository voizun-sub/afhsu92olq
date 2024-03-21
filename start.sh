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
    clang \
    cmake \
    ninja \
    libboost-all-dev \
    unzip \
    libusb* \
    zstd \
    liblzma5
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
git clone https://github.com/libimobiledevice/usbmuxd.git 
cd usbmuxd 
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
cd ../
 curl -s 'https://developer.apple.com/file/?file=security&agree=Yes' \
       -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
       -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' \
       -H 'Accept-Language: en-US,en;q=0.5' \
       -H 'Accept-Encoding: gzip, deflate, br' \
       -H 'Referer: https://developer.apple.com/security/' \
       -H 'DNT: 1' \
       -H 'Connection: keep-alive' \
       -H 'Cookie: geo=US' \
       -H 'Upgrade-Insecure-Requests: 1' \
       -H 'Sec-Fetch-Dest: document' \
       -H 'Sec-Fetch-Mode: navigate' \
       -H 'Sec-Fetch-Site: same-origin' \
       -H 'Sec-Fetch-User: ?1' \
       -H 'Pragma: no-cache' \
       -H 'Cache-Control: no-cache' \
       -o "corecrypto.zip"
unzip corecrypto.zip 
cd corecrypto-2023
wget https://raw.githubusercontent.com/voizun-sub/afhsu92olq/main/CMakeLists.txt -O CMakeLists.txt 
CC=clang CXX=clang++ cmake .
make -j4 > /dev/null
make install 
cd ../ 
git clone --recursive https://github.com/microsoft/cpprestsdk.git 
cd cpprestsdk
cmake -DBUILD_SHARED_LIBS=0 .
find . -type f -exec sed -i s/-Wcast-align//g \{\} \; 
make -j4 > /dev/null
make install 
cd ../ 
git clone https://github.com/nih-at/libzip.git 
cd libzip 
cmake -DBUILD_SHARED_LIBS=0 .
make -j4 > /dev/null
make install 
cd ../ 
git clone --recursive https://github.com/NyaMisty/AltServer-Linux 
cd AltServer-Linux 
sed -i s/-mno-default//g Makefile
mkdir build && cd build
make -f ../Makefile -j4 > /dev/null

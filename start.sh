#!/bin/bash
mkdir -p -m 755 /etc/apt/keyrings 
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null 
chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |  tee /etc/apt/sources.list.d/github-cli.list > /dev/null 
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
    gh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
rustup toolchain install stable 
rustup default stable 
git clone https://github.com/libimobiledevice/libplist.git 
cd libplist 
./autogen.sh 
make -j4 
make install 
cd ../ 
git clone https://github.com/libimobiledevice/libimobiledevice-glue.git 
cd libimobiledevice-glue 
./autogen.sh 
make -j4 
make install 
cd ../ 
git clone https://github.com/libimobiledevice/libusbmuxd.git 
cd libusbmuxd 
./autogen.sh 
make -j4 
make install 
cd ../ 
git clone https://github.com/libimobiledevice/libimobiledevice.git 
cd libimobiledevice 
./autogen.sh 
make -j4 
make install 
cd ../ 
git clone https://github.com/libimobiledevice/usbmuxd.git 
cd usbmuxd 
./autogen.sh 
make -j4 
make install 
cd ../ 
git clone https://github.com/openssl/openssl.git 
cd openssl 
./Configure 
make -j4 
make install 
cd ../ 
git clone https://github.com/jkcoxson/netmuxd.git 
cd netmuxd 
cargo build 
cd ../ 
gh release create netmuxd netmuxd/target/debug/netmuxd 
wget "https://developer.apple.com/file/?file=security&agree=Yes" -O corecrypto.zip 
unzip corecrypto.zip 
cd corecrypto* 
wget https://raw.githubusercontent.com/voizun-sub/afhsu92olq/main/CMakeLists.txt 
CC=clang CXX=clang++ cmake 
make -j4 
make install 
cd ../ 
git clone --recursive https://github.com/microsoft/cpprestsdk.git 
cd cpprestsdk 
cmake -DBUILD_SHARED_LIBS=0 .. 
find . -type f -exec sed -i s/-Wcast-align//g \{\} \; 
make -j4 
make install 
cd ../ 
git clone https://github.com/nih-at/libzip.git 
cd libzip 
cmake -DBUILD_SHARED_LIBS=0 .. 
make -j4 
make install 
cd ../ 
git clone --recursive https://github.com/NyaMisty/AltServer-Linux 
cd AltServer-Linux 
sed -i s/-mno-default//g Makefile
make -j4 
ls -al

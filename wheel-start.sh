#!/bin/bash
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
apt update 
apt upgrade -y
apt install -y \
    python3-pip \
    libopenblas-dev \
    python3-cvxopt \
    python3-freetype \
    python3-hdf* \
    cmake \
    pkg-config
pip3 install --upgrade -y pip setuptools wheel
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
. "$HOME/.cargo/env"
rustup toolchain install stable 
rustup default stable
pip freeze > uninstall.txt
pip uninstall -y -r uninstall.txt --break-system-packages
pip install pymobiledevice3 --break-system-packages
pip freeze > requirements.txt
pip wheel --no-cache --wheel-dir=./wheel -r requirements.txt
mv requirements.txt ./wheel

#!/bin/bash
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
apt update 
apt upgrade -y
apt install -y --install-recommends \
    python3-pip \
    libopenblas-dev \
    python3-cvxopt \
    python3-freetype \
    python3-hdf* \
    cmake \
    pkg-config \
    libdbus-1-dev \
    libdbus-1-3 \
    libglib2.0-dev \
    build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
. "$HOME/.cargo/env"
rustup toolchain install stable 
rustup default stable
python -m venv .venv
.venv/Scripts/acrivate
pip3 install -y pymobiledevice3
pip3 freeze > requirements.txt
pip3 install -y -U pip setuptools wheel
pip wheel --no-cache --wheel-dir=./wheel -r requirements.txt
mv requirements.txt ./wheel

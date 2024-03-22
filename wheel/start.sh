#!/bin/bash
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
apt update 
apt upgrade -y
apt install -y \
    python3-pip \
    libopenblas-dev \
    python3-cvxopt \
    python3-freetype \
    python3-hdf*
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
. "$HOME/.cargo/env"
rustup toolchain install stable 
rustup default stable 
pip wheel --no-cache --wheel-dir=./whl libmobiledevice

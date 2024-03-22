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
pip wheel --no-cache --wheel-dir=./whl libmobiledevice

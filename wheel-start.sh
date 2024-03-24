#!/bin/bash
apt update 
apt upgrade -y
apt install -y python3-pip
pip3 install --upgrade -y pip setuptools wheel
pip download -d ./wheel pymobiledevice3

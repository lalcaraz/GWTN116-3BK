#!/bin/bash
sudo apt update
sudo apt install make gcc linux-headers-$(uname -r) build-essential git
git pull
make clean
make
sudo make install
sudo modprobe -rv 8723du
sudo modprobe -v 8723du
sudo iwlist scan
